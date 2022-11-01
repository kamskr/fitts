part of 'statistics_bloc.dart';

/// {@template statistics_state}
/// The state of the [StatisticsBloc].
/// {@endtemplate}
class StatisticsState extends Equatable {
  /// {@macro statistics_state}
  const StatisticsState({
    this.status = DataLoadingStatus.initial,
    this.userStats,
    this.visibleExerciseKeys = const [],
    this.searchPhrase = '',
    this.exercises = const {},
  });

  /// The current [UserStats].
  final UserStats? userStats;

  /// The current [DataLoadingStatus].
  final DataLoadingStatus status;

  /// The keys of the exercises that are visible. (filtered)
  final List<String> visibleExerciseKeys;

  /// The current search phrase used for filtering exercise stats.
  final String searchPhrase;

  /// Map of all exercises.
  final Map<String, Exercise> exercises;

  @override
  List<Object?> get props => [
        status,
        userStats,
        visibleExerciseKeys,
        searchPhrase,
      ];

  /// Creates a copy of [StatisticsState].
  StatisticsState copyWith({
    DataLoadingStatus? status,
    UserStats? userStats,
    List<String>? visibleExerciseKeys,
    String? searchPhrase,
    Map<String, Exercise>? exercises,
  }) {
    return StatisticsState(
      status: status ?? this.status,
      userStats: userStats ?? this.userStats,
      visibleExerciseKeys: visibleExerciseKeys ?? this.visibleExerciseKeys,
      searchPhrase: searchPhrase ?? this.searchPhrase,
      exercises: exercises ?? this.exercises,
    );
  }
}
