import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'exercises_event.dart';
part 'exercises_state.dart';

/// {@template exercises_bloc}
/// Bloc for managing exercises.
/// {@endtemplate}
class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  /// {@macro exercises_bloc}
  ExercisesBloc({
    required Map<String, Exercise> exercises,
  }) : super(
          ExercisesState(
            exercises: exercises,
          ),
        ) {
    on<ExercisesSearchPhraseChanged>(_onExercisesSearchPhraseChanged);
    on<ExercisesSelectionKeyAdded>(_onExercisesSelectionKeyAdded);
    on<ExercisesSelectionKeyRemoved>(_onExercisesSelectionKeyRemoved);
    on<ExercisesMuscleFilterAdded>(_onExercisesMuscleFilterAdded);
    on<ExercisesMuscleFilterRemoved>(_onExercisesMuscleFilterRemoved);
    on<ExercisesEquipmentFilterAdded>(_onExercisesEquipmentFilterAdded);
    on<ExercisesEquipmentFilterRemoved>(_onExercisesEquipmentFilterRemoved);
  }

  void _onExercisesSearchPhraseChanged(
    ExercisesSearchPhraseChanged event,
    Emitter<ExercisesState> emit,
  ) {}

  void _onExercisesSelectionKeyAdded(
    ExercisesSelectionKeyAdded event,
    Emitter<ExercisesState> emit,
  ) {}

  void _onExercisesSelectionKeyRemoved(
    ExercisesSelectionKeyRemoved event,
    Emitter<ExercisesState> emit,
  ) {}

  void _onExercisesMuscleFilterAdded(
    ExercisesMuscleFilterAdded event,
    Emitter<ExercisesState> emit,
  ) {}

  void _onExercisesMuscleFilterRemoved(
    ExercisesMuscleFilterRemoved event,
    Emitter<ExercisesState> emit,
  ) {}

  void _onExercisesEquipmentFilterAdded(
    ExercisesEquipmentFilterAdded event,
    Emitter<ExercisesState> emit,
  ) {}

  void _onExercisesEquipmentFilterRemoved(
    ExercisesEquipmentFilterRemoved event,
    Emitter<ExercisesState> emit,
  ) {}
}
