part of 'exercises_bloc.dart';

/// {@template exercises_state}
/// State used for managing exercises.
/// {@endtemplate}
class ExercisesState extends Equatable {
  /// {@macro exercises_state}
  const ExercisesState({
    required this.exercises,
    this.searchString = '',
    this.selectedKeys = const [],
    this.muscleFilter = const [],
    this.equipmentFilter = const [],
  });

  /// The list of exercises to display.
  final Map<String, Exercise> exercises;

  /// The search string to filter the exercises by.
  final String searchString;

  /// The keys of the selected exercises.
  final List<String> selectedKeys;

  /// The muscle filter to filter the exercises by.
  final List<Muscle> muscleFilter;

  /// The equipment filter to filter the exercises by.
  final List<Equipment> equipmentFilter;

  @override
  List<Object> get props => [
        exercises,
        searchString,
        muscleFilter,
        equipmentFilter,
        selectedKeys,
      ];
}
