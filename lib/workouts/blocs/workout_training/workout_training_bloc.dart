import 'dart:async';
import 'dart:math';

import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_stats_repository/user_stats_repository.dart';
import 'package:workouts_repository/workouts_repository.dart';

part 'workout_training_event.dart';
part 'workout_training_state.dart';

class _Ticker {
  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (x) => x++);
  }
}

/// {@template workout_training_bloc}
/// The bloc responsible for handling the workout training.
/// {@endtemplate}
class WorkoutTrainingBloc
    extends Bloc<WorkoutTrainingEvent, WorkoutTrainingState> {
  /// {@macro workout_training_bloc}
  WorkoutTrainingBloc({
    required UserStatsRepository userStatsRepository,
    required WorkoutsRepository workoutsRepository,
  })  : _userStatsRepository = userStatsRepository,
        _workoutsRepository = workoutsRepository,
        super(WorkoutTrainingInitial()) {
    on<WorkoutTrainingStart>(_onWorkoutTrainingStart);
    on<WorkoutTrainingFinish>(_onWorkoutTrainingFinish);
    on<WorkoutTrainingStartRestTimer>(_onWorkoutTrainingStartRestTimer);
    on<WorkoutTrainingTickerEvent>(_onWorkoutTrainingTickerEvent);
  }

  final UserStatsRepository _userStatsRepository;
  final WorkoutsRepository _workoutsRepository;
  StreamSubscription<int>? _tickerSubscription;

  Future<void> _onWorkoutTrainingStart(
    WorkoutTrainingStart event,
    Emitter<WorkoutTrainingState> emit,
  ) async {
    _tickerSubscription = _Ticker().tick().listen(_onTick);
    final workoutLog = WorkoutLog.empty.copyWith(
      id: '${DateTime.now().toIso8601String()}${event.workoutTemplate.name}log',
      workoutTemplate: event.workoutTemplate,
      datePerformed: DateTime.now(),
    );

    emit(
      WorkoutTrainingInProgress(
        workoutTemplate: event.workoutTemplate,
        workoutLog: workoutLog,
      ),
    );
  }

  Future<void> _onWorkoutTrainingStartRestTimer(
    WorkoutTrainingStartRestTimer event,
    Emitter<WorkoutTrainingState> emit,
  ) async {
    if (state is WorkoutTrainingInProgress) {
      emit(
        (state as WorkoutTrainingInProgress).copyWith(
          remainingRestTime: event.restTime,
        ),
      );
    }
  }

  Future<void> _onWorkoutTrainingTickerEvent(
    WorkoutTrainingTickerEvent event,
    Emitter<WorkoutTrainingState> emit,
  ) async {
    if (state is! WorkoutTrainingInProgress) {
      return;
    }
    final currentState = state as WorkoutTrainingInProgress;
    final currentDuration = DateTime.now().difference(
      currentState.workoutLog.datePerformed,
    );

    emit(
      currentState.copyWith(
        duration: currentDuration.inSeconds,
        remainingRestTime: max(currentState.remainingRestTime - 1, 0),
      ),
    );
  }

  void _onTick(int event) {
    add(const WorkoutTrainingTickerEvent());
  }

  Future<void> _onWorkoutTrainingFinish(
    WorkoutTrainingFinish event,
    Emitter<WorkoutTrainingState> emit,
  ) async {
    final state = this.state as WorkoutTrainingInProgress;
    await _tickerSubscription?.cancel();
    _tickerSubscription = null;
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      // Update user stats
      final currentStats =
          (await _userStatsRepository.userStats.first) ?? UserStats.empty;

      var updatedWorkoutLog = state.workoutLog.copyWith(
        duration: state.duration,
        exercises: event.workoutTemplate.exercises,
      );

      // Update template.
      final updatedAverageWorkoutLength = (state
                  .workoutTemplate.averageWorkoutLength ??
              0 * state.workoutTemplate.workoutsCompleted + state.duration) /
          (state.workoutTemplate.workoutsCompleted + 1);

      var updatedTemplate = state.workoutTemplate.copyWith(
        averageWorkoutLength: updatedAverageWorkoutLength.toInt(),
        lastPerformed: updatedWorkoutLog.datePerformed,
        lastAverageRestTime: updatedWorkoutLog.averageRestTime,
        recentTotalTonnageLifted:
            state.workoutTemplate.recentTotalTonnageLifted == null
                ? [updatedWorkoutLog.totalWeight.toInt()]
                : [
                    ...state.workoutTemplate.recentTotalTonnageLifted!,
                    updatedWorkoutLog.totalWeight.toInt()
                  ],
        tonnageLifted: state.workoutTemplate.tonnageLifted +
            updatedWorkoutLog.totalWeight.toInt(),
        workoutsCompleted: state.workoutTemplate.workoutsCompleted + 1,
      );

      if (event.updateTemplate) {
        updatedTemplate = updatedTemplate.copyWith(
          exercises: event.workoutTemplate.exercises,
          name: event.workoutTemplate.name,
          notes: event.workoutTemplate.notes,
        );
      }

      updatedWorkoutLog = updatedWorkoutLog.copyWith(
        workoutTemplate: updatedTemplate,
      );

      final updatedGlobalStats = currentStats.globalStats.copyWith(
        liftingTimeSpent: currentStats.globalStats.liftingTimeSpent +
            updatedWorkoutLog.duration,
        totalKgLifted: currentStats.globalStats.totalKgLifted +
            updatedWorkoutLog.totalWeight.toInt(),
        workoutsCompleted: currentStats.globalStats.workoutsCompleted + 1,
      );

      final updatedUserStats = currentStats.copyWith(
        globalStats: updatedGlobalStats,
        exercisesStats: currentStats.exercisesStats.isEmpty
            ? {}
            : currentStats.exercisesStats,
      );

      for (final exercise in updatedWorkoutLog.exercises) {
        final previousStats = currentStats.exercisesStats[exercise.exerciseId];

        final totalReps = exercise.sets.fold<int>(
          previousStats?.repetitionsDone ?? 0,
          (previousValue, element) => previousValue + element.repetitions,
        );

        final highestWeight = exercise.sets.fold<double>(
          previousStats?.highestWeight ?? 0,
          (previousValue, element) => max(previousValue, element.weight),
        );

        final timesPerformed = (previousStats?.timesPerformed ?? 0) + 1;

        final prevOverallBestValue =
            (previousStats?.overallBest.repetitions ?? 0) *
                (previousStats?.overallBest.weight ?? 0.0);

        var currentOverallBest = previousStats?.overallBest ??
            const OverallBest(weight: 0, repetitions: 0);

        for (final set in exercise.sets) {
          final value = set.repetitions * set.weight;

          if (value > prevOverallBestValue) {
            currentOverallBest = OverallBest(
              repetitions: set.repetitions,
              weight: set.weight,
            );
          }
        }

        final newExerciseStats = ExerciseStats(
          timesPerformed: timesPerformed,
          repetitionsDone: totalReps,
          highestWeight: highestWeight,
          overallBest: currentOverallBest,
        );

        updatedUserStats.exercisesStats[exercise.exerciseId] = newExerciseStats;
      }

      // Update values on the backend
      await _userStatsRepository.updateUserStats(
        payload: updatedUserStats,
      );

      await _workoutsRepository.updateWorkoutTemplate(
        workoutTemplateId: updatedTemplate.id,
        workoutTemplate: updatedTemplate,
      );
      await _workoutsRepository.createWorkoutLog(workoutLog: updatedWorkoutLog);

      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );

      Future.delayed(
        const Duration(seconds: 300),
        () => emit(
          WorkoutTrainingInitial(),
        ),
      );

      // emit(WorkoutTrainingInitial());
    } catch (e, st) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      addError(e, st);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
