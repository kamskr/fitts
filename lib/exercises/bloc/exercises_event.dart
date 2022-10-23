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

/// {@template exercises_initialized}
///  Event for initializing exercises.
/// {@endtemplate}
class ExercisesInitialized extends ExercisesEvent {
  /// {@macro exercises_initialized}
  const ExercisesInitialized();
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

/// {@template exercises_filters_changed}
/// Event for changing exercises filters.
/// {@endtemplate}
class ExercisesFiltersChanged extends ExercisesEvent {
  /// {@macro exercises_filters_changed}
  const ExercisesFiltersChanged(this.muscleFilter, this.equipmentFilter);

  /// The muscle filter to filter the exercises by.
  final List<Muscle> muscleFilter;

  /// The equipment filter to filter the exercises by.
  final List<Equipment> equipmentFilter;

  @override
  List<Object> get props => [
        muscleFilter,
        equipmentFilter,
      ];
}
