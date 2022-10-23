part of 'exercises_bloc.dart';

/// {@template exercises_event}
/// Template for exercises events.
/// {@endtemplate}
abstract class ExercisesEvent extends Equatable {
  /// {@macro exercises_event}
  const ExercisesEvent();

  @override
  List<Object> get props => [];
}

/// {@template exercises_search_phrase_changed}
///  Event for changing search phrase.
/// {@endtemplate}
class ExercisesSearchPhraseChanged extends ExercisesEvent {
  /// {@macro exercises_search_phrase_changed}
  const ExercisesSearchPhraseChanged(
    this.searchPhrase,
  );

  /// New search phrase..
  final String searchPhrase;

  @override
  List<Object> get props => [searchPhrase];
}

/// {@template exercises_selection_key_added}
///  Event for adding key selection.
/// {@endtemplate}
class ExercisesSelectionKeyAdded extends ExercisesEvent {
  /// {@macro exercises_selection_key_added}
  const ExercisesSelectionKeyAdded(
    this.key,
  );

  /// The key of the exercise to select.
  final String key;

  @override
  List<Object> get props => [key];
}

/// {@template exercises_selection_key_removed}
///  Event for removing key selection.
/// {@endtemplate}
class ExercisesSelectionKeyRemoved extends ExercisesEvent {
  /// {@macro exercises_selection_key_removed}
  const ExercisesSelectionKeyRemoved(
    this.key,
  );

  /// The key of the exercise to unselect.
  final String key;

  @override
  List<Object> get props => [key];
}

/// {@template exercises_muscle_filter_added}
/// Event for adding muscle filter.
/// {@endtemplate}
class ExercisesMuscleFilterAdded extends ExercisesEvent {
  /// {@macro exercises_muscle_filter_added}
  const ExercisesMuscleFilterAdded(
    this.muscle,
  );

  /// Muscle to add to filters.
  final Muscle muscle;

  @override
  List<Object> get props => [muscle];
}

/// {@template exercises_muscle_filter_removed}
///  Event for removing muscle selection.
/// {@endtemplate}
class ExercisesMuscleFilterRemoved extends ExercisesEvent {
  /// {@macro exercises_muscle_filter_removed}
  const ExercisesMuscleFilterRemoved(
    this.muscle,
  );

  /// Muscle to remove from filters.
  final Muscle muscle;

  @override
  List<Object> get props => [muscle];
}

/// {@template exercises_equipment_filter_added}
/// Event for adding equipment filter.
/// {@endtemplate}
class ExercisesEquipmentFilterAdded extends ExercisesEvent {
  /// {@macro exercises_equipment_filter_added}
  const ExercisesEquipmentFilterAdded(
    this.equipment,
  );

  /// Equipment to add to filters.
  final Equipment equipment;

  @override
  List<Object> get props => [equipment];
}

/// {@template exercises_equipment_filter_removed}
/// Event for removing equipment selection.
/// {@endtemplate}
class ExercisesEquipmentFilterRemoved extends ExercisesEvent {
  /// {@macro exercises_equipment_filter_removed}
  const ExercisesEquipmentFilterRemoved(
    this.equipment,
  );

  /// Equipment to remove from filters.
  final Equipment equipment;

  @override
  List<Object> get props => [equipment];
}
