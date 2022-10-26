import 'dart:async';
import 'dart:math';

import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
  WorkoutTrainingBloc() : super(WorkoutTrainingInitial()) {
    on<WorkoutTrainingStart>(_onWorkoutTrainingStart);
    on<WorkoutTrainingFinish>(_onWorkoutTrainingFinish);
    on<WorkoutTrainingStartRestTimer>(_onWorkoutTrainingStartRestTimer);
    on<WorkoutTrainingTickerEvent>(_onWorkoutTrainingTickerEvent);
  }

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

  Future<void> _onWorkoutTrainingFinish(
    WorkoutTrainingFinish event,
    Emitter<WorkoutTrainingState> emit,
  ) async {
    await _tickerSubscription?.cancel();
    _tickerSubscription = null;

    emit(WorkoutTrainingInitial());
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

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
