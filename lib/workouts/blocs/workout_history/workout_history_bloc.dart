import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitts/utils/utils.dart';
import 'package:workouts_repository/workouts_repository.dart';

part 'workout_history_event.dart';
part 'workout_history_state.dart';

/// {@template workout_history_bloc}
/// Bloc used for managing user's workout history.
/// {@endtemplate}
class WorkoutHistoryBloc
    extends Bloc<WorkoutHistoryEvent, WorkoutHistoryState> {
  /// {@macro workout_history_bloc}
  WorkoutHistoryBloc({
    required WorkoutsRepository workoutsRepository,
  })  : _workoutsRepository = workoutsRepository,
        super(const WorkoutHistoryState()) {
    on<WorkoutLogsSubscriptionRequested>(_onWorkoutLogsSubscriptionRequested);
  }

  final WorkoutsRepository _workoutsRepository;

  Future<void> _onWorkoutLogsSubscriptionRequested(
    WorkoutLogsSubscriptionRequested event,
    Emitter<WorkoutHistoryState> emit,
  ) async {
    await emit.forEach<List<WorkoutLog>?>(
      _workoutsRepository.getWorkoutLogs(),
      onData: (workoutLogsHistory) {
        return state.copyWith(
          workoutLogsHistory: workoutLogsHistory,
          status: DataLoadingStatus.success,
        );
      },
      onError: (_, __) => state.copyWith(
        status: DataLoadingStatus.error,
      ),
    );
  }
}
