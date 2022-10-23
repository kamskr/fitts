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
            visibleExercises: exercises.values.toList(),
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
  ) {
    final filteredExercises =
        _getFilteredExercises(searchPhrase: event.searchPhrase);

    emit(
      state.copyWith(
        searchPhrase: event.searchPhrase,
        visibleExercises: filteredExercises,
      ),
    );
  }

  void _onExercisesSelectionKeyAdded(
    ExercisesSelectionKeyAdded event,
    Emitter<ExercisesState> emit,
  ) {
    final selectedKeys = List<String>.from(state.selectedKeys)..add(event.key);

    emit(
      state.copyWith(
        selectedKeys: selectedKeys,
      ),
    );
  }

  void _onExercisesSelectionKeyRemoved(
    ExercisesSelectionKeyRemoved event,
    Emitter<ExercisesState> emit,
  ) {
    final selectedKeys = List<String>.from(state.selectedKeys)
      ..removeWhere((key) => key == event.key);

    emit(
      state.copyWith(
        selectedKeys: selectedKeys,
      ),
    );
  }

  void _onExercisesMuscleFilterAdded(
    ExercisesMuscleFilterAdded event,
    Emitter<ExercisesState> emit,
  ) {
    final muscleFilter = List<Muscle>.from(state.muscleFilter)
      ..add(event.muscle);

    final filteredExercises = _getFilteredExercises(muscleFilter: muscleFilter);

    emit(
      state.copyWith(
        muscleFilter: muscleFilter,
        visibleExercises: filteredExercises,
      ),
    );
  }

  void _onExercisesMuscleFilterRemoved(
    ExercisesMuscleFilterRemoved event,
    Emitter<ExercisesState> emit,
  ) {
    final muscleFilter = List<Muscle>.from(state.muscleFilter)
      ..removeWhere((muscle) => muscle == event.muscle);

    final filteredExercises = _getFilteredExercises(muscleFilter: muscleFilter);

    emit(
      state.copyWith(
        muscleFilter: muscleFilter,
        visibleExercises: filteredExercises,
      ),
    );
  }

  void _onExercisesEquipmentFilterAdded(
    ExercisesEquipmentFilterAdded event,
    Emitter<ExercisesState> emit,
  ) {
    final equipmentFilter = List<Equipment>.from(state.equipmentFilter)
      ..add(event.equipment);

    final filteredExercises =
        _getFilteredExercises(equipmentFilter: equipmentFilter);

    emit(
      state.copyWith(
        equipmentFilter: equipmentFilter,
        visibleExercises: filteredExercises,
      ),
    );
  }

  void _onExercisesEquipmentFilterRemoved(
    ExercisesEquipmentFilterRemoved event,
    Emitter<ExercisesState> emit,
  ) {
    final equipmentFilter = List<Equipment>.from(state.equipmentFilter)
      ..removeWhere((equipment) => equipment == event.equipment);

    final filteredExercises =
        _getFilteredExercises(equipmentFilter: equipmentFilter);

    emit(
      state.copyWith(
        equipmentFilter: equipmentFilter,
        visibleExercises: filteredExercises,
      ),
    );
  }

  List<Exercise> _getFilteredExercises({
    String? searchPhrase,
    List<Muscle>? muscleFilter,
    List<Equipment>? equipmentFilter,
  }) {
    final _searchPhrase = searchPhrase ?? state.searchPhrase;
    final _muscleFilter = muscleFilter ?? state.muscleFilter;
    final _equipmentFilter = equipmentFilter ?? state.equipmentFilter;

    return state.exercises.values.where((exercise) {
      final nameMatches =
          exercise.name.toLowerCase().contains(_searchPhrase.toLowerCase());

      late final bool muscleFilterMatches;
      late final bool equipmentFilterMatches;

      if (_muscleFilter.isEmpty) {
        muscleFilterMatches = true;
      } else {
        muscleFilterMatches = _muscleFilter.any(
          (muscle) =>
              exercise.primaryMuscles.contains(muscle) ||
              exercise.secondaryMuscles.contains(muscle),
        );
      }

      if (_muscleFilter.isEmpty) {
        equipmentFilterMatches = true;
      } else if (exercise.equipment == null) {
        equipmentFilterMatches = false;
      } else {
        equipmentFilterMatches = _equipmentFilter.any(
          (equipment) => exercise.equipment == equipment,
        );
      }

      return nameMatches && muscleFilterMatches && equipmentFilterMatches;
    }).toList();
  }
}
