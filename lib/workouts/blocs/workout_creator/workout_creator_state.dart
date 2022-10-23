part of 'workout_creator_bloc.dart';

/// {@template workout_creator_state}
/// State for workout creator/
/// {@endtemplate}
class WorkoutCreatorState extends Equatable {
  /// {@macro workout_creator_state}
  const WorkoutCreatorState({
    this.workoutTemplate = WorkoutTemplate.empty,
    this.status = FormzStatus.pure,
  });

  /// Current state of [WorkoutTemplate].
  final WorkoutTemplate workoutTemplate;

  /// Current status of the state.
  final FormzStatus status;

  @override
  List<Object> get props => [workoutTemplate, status];

  /// Creates a copy of [WorkoutCreatorState].
  WorkoutCreatorState copyWith({
    WorkoutTemplate? workoutTemplate,
    FormzStatus? status,
  }) {
    return WorkoutCreatorState(
      workoutTemplate: workoutTemplate ?? this.workoutTemplate,
      status: status ?? this.status,
    );
  }
}
