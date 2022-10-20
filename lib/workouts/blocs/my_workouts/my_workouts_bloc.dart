import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitts/utils/utils.dart';
import 'package:workouts_repository/workouts_repository.dart';

part 'my_workouts_event.dart';
part 'my_workouts_state.dart';

/// {@template my_workouts_bloc}
/// The bloc responsible for fetching data used by my_workouts_page.
/// {@endtemplate}
class MyWorkoutsBloc extends Bloc<MyWorkoutsEvent, MyWorkoutsState> {
  /// {@macro my_workouts_bloc}
  MyWorkoutsBloc({
    required WorkoutsRepository workoutsRepository,
  })  : _workoutsRepository = workoutsRepository,
        super(const MyWorkoutsState()) {
    on<WorkoutTemplatesSubscriptionRequested>(
      _onWorkoutTemplatesSubscriptionRequested,
    );
  }
  final WorkoutsRepository _workoutsRepository;

  Future<void> _onWorkoutTemplatesSubscriptionRequested(
    WorkoutTemplatesSubscriptionRequested event,
    Emitter<MyWorkoutsState> emit,
  ) async {
    await emit.forEach<List<WorkoutTemplate>?>(
      _workoutsRepository.getWorkoutTemplates(),
      onData: (workoutTemplates) {
        return state.copyWith(
          workoutTemplates: workoutTemplates,
          status: DataLoadingStatus.success,
        );
      },
      onError: (_, __) => state.copyWith(
        status: DataLoadingStatus.error,
      ),
    );
  }
}
