import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'workout_creator_event.dart';
part 'workout_creator_state.dart';

/// {@template workout_creator_bloc}
/// Bloc used for creating and editing workout templates.
/// {@endtemplate}
class WorkoutCreatorBloc
    extends Bloc<WorkoutCreatorEvent, WorkoutCreatorState> {
  /// {@macro workout_creator_bloc}
  WorkoutCreatorBloc() : super(const WorkoutCreatorState()) {
    on<WorkoutCreatorTemplateChanged>(_onWorkoutCreatorTemplateChanged);
    on<WorkoutCreatorSubmitTemplate>(_onWorkoutCreatorSubmitTemplate);
    on<WorkoutCreatorAddExercises>(_onWorkoutCreatorAddExercises);
    on<WorkoutCreatorExerciseChanged>(_onWorkoutCreatorExerciseChanged);
    on<WorkoutCreatorReorderExercises>(_onWorkoutCreatorReorderExercises);
    on<WorkoutCreatorDeleteExercise>(_onWorkoutCreatorDeleteExercise);
    on<WorkoutCreatorDeleteExerciseSet>(_onWorkoutCreatorDeleteExerciseSet);
  }
  Future<void> _onWorkoutCreatorTemplateChanged(
    WorkoutCreatorTemplateChanged event,
    Emitter<WorkoutCreatorState> emit,
  ) async {
    emit(
      state.copyWith(
        workoutTemplate: event.workoutTemplate,
        status: FormzStatus.valid,
      ),
    );
  }

  Future<void> _onWorkoutCreatorExerciseChanged(
    WorkoutCreatorExerciseChanged event,
    Emitter<WorkoutCreatorState> emit,
  ) async {
    final exercises = List.of(state.workoutTemplate.exercises);
    exercises[event.exerciseIndex] = event.exercise;

    emit(
      state.copyWith(
        workoutTemplate: state.workoutTemplate.copyWith(
          exercises: exercises,
        ),
        status: FormzStatus.valid,
      ),
    );
  }

  Future<void> _onWorkoutCreatorAddExercises(
    WorkoutCreatorAddExercises event,
    Emitter<WorkoutCreatorState> emit,
  ) async {
    final exercisesToAdd = event.exercises.map((exercise) {
      return WorkoutExercise(
        exerciseId: exercise.id,
        notes: '',
        restTime: 0,
        sets: const [],
      );
    });

    final workoutExercises = [
      ...state.workoutTemplate.exercises,
      ...exercisesToAdd,
    ];

    final newTemplate = state.workoutTemplate.copyWith(
      exercises: workoutExercises,
    );

    emit(
      state.copyWith(
        workoutTemplate: newTemplate,
        status: FormzStatus.valid,
      ),
    );
  }

  Future<void> _onWorkoutCreatorReorderExercises(
    WorkoutCreatorReorderExercises event,
    Emitter<WorkoutCreatorState> emit,
  ) async {
    var newIndex = event.newIndex;
    final oldIndex = event.oldIndex;

    final exercises = List.of(state.workoutTemplate.exercises);

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = exercises.removeAt(oldIndex);
    exercises.insert(newIndex, item);

    emit(
      state.copyWith(
        workoutTemplate: state.workoutTemplate.copyWith(
          exercises: exercises,
        ),
        status: FormzStatus.valid,
      ),
    );
  }

  Future<void> _onWorkoutCreatorDeleteExercise(
    WorkoutCreatorDeleteExercise event,
    Emitter<WorkoutCreatorState> emit,
  ) async {
    final exercises = List.of(state.workoutTemplate.exercises)
      ..removeAt(event.index);

    emit(
      state.copyWith(
        workoutTemplate: state.workoutTemplate.copyWith(
          exercises: List.of(exercises),
        ),
        status: FormzStatus.invalid,
      ),
    );
  }

  Future<void> _onWorkoutCreatorSubmitTemplate(
    WorkoutCreatorSubmitTemplate event,
    Emitter<WorkoutCreatorState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      // perform async operation
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      addError(error, stackTrace);
    }
  }

  Future<void> _onWorkoutCreatorDeleteExerciseSet(
    WorkoutCreatorDeleteExerciseSet event,
    Emitter<WorkoutCreatorState> emit,
  ) async {
    final exercises = List.of(state.workoutTemplate.exercises);
    final exercise = exercises[event.exerciseIndex];
    final sets = List.of(exercise.sets)..removeAt(event.setIndex);

    exercises[event.exerciseIndex] = exercise.copyWith(sets: sets);

    emit(
      state.copyWith(
        workoutTemplate: state.workoutTemplate.copyWith(
          exercises: exercises,
        ),
        status: FormzStatus.valid,
      ),
    );
  }
}
