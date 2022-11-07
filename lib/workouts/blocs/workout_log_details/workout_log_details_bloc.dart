import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_stats_repository/user_stats_repository.dart';
import 'package:workouts_repository/workouts_repository.dart';

part 'workout_log_details_event.dart';
part 'workout_log_details_state.dart';

/// {@template workout_log_details_bloc}
/// BLoC for managing the logic of WorkoutLogDetailsPage.
/// {@endtemplate}
class WorkoutLogDetailsBloc
    extends Bloc<WorkoutLogDetailsEvent, WorkoutLogDetailsState> {
  /// {@macro workout_log_details_bloc}
  WorkoutLogDetailsBloc({
    required WorkoutLog workoutLog,
    required UserStatsRepository userStatsRepository,
    required WorkoutsRepository workoutsRepository,
  })  : _userStatsRepository = userStatsRepository,
        _workoutsRepository = workoutsRepository,
        super(WorkoutLogDetailsState(workoutLog: workoutLog)) {
    on<WorkoutLogDeleted>(_onWorkoutLogDeleted);
  }

  final UserStatsRepository _userStatsRepository;
  final WorkoutsRepository _workoutsRepository;

  Future<void> _onWorkoutLogDeleted(
    WorkoutLogDeleted event,
    Emitter<WorkoutLogDetailsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await _workoutsRepository.deleteWorkoutLog(
        workoutLogId: state.workoutLog.id,
      );

      // Update template.
      final currentWorkoutTemplate = await _workoutsRepository
          .getWorkoutTemplateById(
            workoutTemplateId: state.workoutLog.workoutTemplate.id,
          )
          .first;

      if (currentWorkoutTemplate == null) {
        return;
      }

      final lastExistingWorkoutLog =
          (await _workoutsRepository.getWorkoutLogs().first)?.firstWhereOrNull(
        (workoutLog) =>
            workoutLog.workoutTemplate.id == currentWorkoutTemplate.id,
      );

      if (lastExistingWorkoutLog == null) {
        await _workoutsRepository.updateWorkoutTemplate(
          workoutTemplateId: currentWorkoutTemplate.id,
          workoutTemplate: currentWorkoutTemplate.copyWith(
            workoutsCompleted: 0,
            tonnageLifted: 0,
            averageWorkoutLength: 0,
            lastAverageRestTime: 0,
            recentTotalTonnageLifted: [],
          ),
        );
      } else {
        final previousWorkoutTemplate = lastExistingWorkoutLog.workoutTemplate;
        final recentTotalTonnageLifted =
            (previousWorkoutTemplate.recentTotalTonnageLifted ?? [])
              ..removeWhere(
                (value) =>
                    value.timePerformed == state.workoutLog.datePerformed,
              );

        await _workoutsRepository.updateWorkoutTemplate(
          workoutTemplateId: currentWorkoutTemplate.id,
          workoutTemplate: currentWorkoutTemplate.copyWith(
            workoutsCompleted: previousWorkoutTemplate.workoutsCompleted,
            tonnageLifted: previousWorkoutTemplate.tonnageLifted,
            averageWorkoutLength: previousWorkoutTemplate.averageWorkoutLength,
            lastAverageRestTime: previousWorkoutTemplate.lastAverageRestTime,
            recentTotalTonnageLifted: recentTotalTonnageLifted,
            lastPerformed: previousWorkoutTemplate.lastPerformed,
          ),
        );
      }

      // Update stats
      final currentUserStats = await _userStatsRepository.userStats.first;

      if (currentUserStats == null) {
        return;
      }

      // Update exercise stats.
      for (final exercise in state.workoutLog.exercises) {
        final currentExerciseStats =
            currentUserStats.exercisesStats[exercise.exerciseId];

        if (currentExerciseStats == null) {
          return;
        }

        final updatedHistory = (currentExerciseStats.history?.toList() ??
                <ExercisePerformHistory>[])
            .where(
              (exerciseHistory) =>
                  exerciseHistory.datePerformed !=
                  state.workoutLog.datePerformed,
            )
            .toList();

        final repetitionsDone =
            currentExerciseStats.repetitionsDone - exercise.totalReps;
        final timesPerformed = currentExerciseStats.timesPerformed - 1;
        var highestWeightLifted = 0.0;
        var overallBest = const OverallBest(repetitions: 0, weight: 0);

        for (final historyItem in updatedHistory) {
          final currHighestWeight = historyItem.details.highestWeight;
          if (currHighestWeight > highestWeightLifted) {
            highestWeightLifted = currHighestWeight;
          }

          final currOverallBest = historyItem.details.overallBest;
          if ((currOverallBest.repetitions * currOverallBest.weight) >
              (overallBest.repetitions * overallBest.weight)) {
            overallBest = currOverallBest;
          }
        }
        currentUserStats.exercisesStats[exercise.exerciseId] =
            currentExerciseStats.copyWith(
          history: updatedHistory,
          repetitionsDone: repetitionsDone,
          timesPerformed: timesPerformed,
          highestWeight: highestWeightLifted,
          overallBest: overallBest,
        );

        await _userStatsRepository.updateUserStats(
          payload: currentUserStats.copyWith(
            globalStats: currentUserStats.globalStats.copyWith(
              liftingTimeSpent: currentUserStats.globalStats.liftingTimeSpent -
                  state.workoutLog.duration,
              totalKgLifted: currentUserStats.globalStats.totalKgLifted -
                  state.workoutLog.totalWeight.toInt(),
              workoutsCompleted:
                  currentUserStats.globalStats.workoutsCompleted - 1,
            ),
          ),
        );
      }

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e, st) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      addError(e, st);
    }
  }
}
