part of 'exercises_bloc.dart';

/// {@template exercises_state}
/// State used for managing exercises.
/// {@endtemplate}
class ExercisesState extends Equatable {
  /// {@macro exercises_state}
  const ExercisesState({
    required this.exercises,
    required this.visibleExercises,
    this.searchPhrase = '',
    this.selectedKeys = const [],
    this.muscleFilter = const [],
    this.equipmentFilter = const [],
  });

  /// Map of all exercises.
  final Map<String, Exercise> exercises;

  /// List of visible exercises.
  final List<Exercise> visibleExercises;

  /// The search string to filter the exercises by.
  final String searchPhrase;

  /// The keys of the selected exercises.
  final List<String> selectedKeys;

  /// The muscle filter to filter the exercises by.
  final List<Muscle> muscleFilter;

  /// The equipment filter to filter the exercises by.
  final List<Equipment> equipmentFilter;

  @override
  List<Object> get props => [
        exercises,
        searchPhrase,
        muscleFilter,
        equipmentFilter,
        selectedKeys,
      ];

  /// Returns a copy of the state.
  ExercisesState copyWith({
    Map<String, Exercise>? exercises,
    List<Exercise>? visibleExercises,
    String? searchPhrase,
    List<String>? selectedKeys,
    List<Muscle>? muscleFilter,
    List<Equipment>? equipmentFilter,
  }) {
    return ExercisesState(
      exercises: exercises ?? this.exercises,
      visibleExercises: visibleExercises ?? this.visibleExercises,
      searchPhrase: searchPhrase ?? this.searchPhrase,
      selectedKeys: selectedKeys ?? this.selectedKeys,
      muscleFilter: muscleFilter ?? this.muscleFilter,
      equipmentFilter: equipmentFilter ?? this.equipmentFilter,
    );
  }
}
