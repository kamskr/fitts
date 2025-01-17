import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercises_repository/exercises_repository.dart';
import 'package:fitts/utils/utils.dart';

part 'exercises_event.dart';
part 'exercises_state.dart';

/// {@template exercises_bloc}
/// Bloc for managing exercises.
/// {@endtemplate}
class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  /// {@macro exercises_bloc}
  ExercisesBloc({
    required ExercisesRepository exercisesRepository,
  })  : _exercisesRepository = exercisesRepository,
        super(
          const ExercisesState(),
        ) {
    on<ExercisesInitialized>(_onExercisesInitialized);
    on<ExercisesSearchPhraseChanged>(_onExercisesSearchPhraseChanged);
    on<ExercisesSelectionKeyAdded>(_onExercisesSelectionKeyAdded);
    on<ExercisesSelectionKeyRemoved>(_onExercisesSelectionKeyRemoved);
    on<ExercisesFiltersChanged>(_onExercisesFiltersChanged);
  }

  final ExercisesRepository _exercisesRepository;

  Future<void> _onExercisesInitialized(
    ExercisesInitialized event,
    Emitter<ExercisesState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: DataLoadingStatus.loading,
        ),
      );
      final exercises = await _exercisesRepository.getExercises();
      emit(
        state.copyWith(
          status: DataLoadingStatus.success,
          exercises: exercises,
          visibleExercises: exercises.values.toList(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DataLoadingStatus.error,
        ),
      );
    }
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

  void _onExercisesFiltersChanged(
    ExercisesFiltersChanged event,
    Emitter<ExercisesState> emit,
  ) {
    final filteredExercises = _getFilteredExercises(
      muscleFilter: event.muscleFilter,
      equipmentFilter: event.equipmentFilter,
    );

    emit(
      state.copyWith(
        muscleFilter: event.muscleFilter,
        equipmentFilter: event.equipmentFilter,
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
        muscleFilterMatches = _muscleFilter.every(
          (muscle) {
            final matches = exercise.primaryMuscles.contains(muscle) ||
                exercise.secondaryMuscles.contains(muscle);
            return matches;
          },
        );
      }

      if (_equipmentFilter.isEmpty) {
        equipmentFilterMatches = true;
      } else if (exercise.equipment == null) {
        equipmentFilterMatches = false;
      } else {
        equipmentFilterMatches = _equipmentFilter.every(
          (equipment) => exercise.equipment == equipment,
        );
      }

      return nameMatches && muscleFilterMatches && equipmentFilterMatches;
    }).toList();
  }
}
