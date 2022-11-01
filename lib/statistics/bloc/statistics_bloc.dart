import 'dart:async';

import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercises_repository/exercises_repository.dart';
import 'package:fitts/utils/utils.dart';
import 'package:user_stats_repository/user_stats_repository.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

/// {@template statistics_bloc}
/// BLoC that manages the statistics screens.
/// {@endtemplate}
class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  /// {@macro statistics_bloc}
  StatisticsBloc({
    required ExercisesRepository exercisesRepository,
    required UserStatsRepository userStatsRepository,
  })  : _exercisesRepository = exercisesRepository,
        _userStatsRepository = userStatsRepository,
        super(const StatisticsState()) {
    on<StatisticsChanged>(_onStatisticsChanged);
    on<StatisticsLoadingError>(_onStatisticsLoadingError);
    on<StatisticsSearchPhraseChanged>(_onStatisticsSearchPhraseChanged);
    _userStatsSubscription = _userStatsRepository.userStats.handleError((_) {
      add(StatisticsLoadingError(Exception('Failed to load user stats')));
    }).listen((userStats) => add(StatisticsChanged(userStats)));
  }

  final ExercisesRepository _exercisesRepository;
  final UserStatsRepository _userStatsRepository;

  late StreamSubscription<UserStats?> _userStatsSubscription;

  Future<void> _onStatisticsChanged(
    StatisticsChanged event,
    Emitter<StatisticsState> emit,
  ) async {
    final exercises = state.exercises.isEmpty
        ? await _exercisesRepository.getExercises()
        : state.exercises;

    final visibleExerciseKeys = _getFilteredExerciseKeys(
      exercises: exercises,
      searchPhrase: state.searchPhrase,
      userStats: event.userStats,
    );

    emit(
      state.copyWith(
        userStats: event.userStats,
        exercises: exercises,
        visibleExerciseKeys: visibleExerciseKeys,
        status: DataLoadingStatus.success,
      ),
    );
  }

  void _onStatisticsLoadingError(
    StatisticsLoadingError event,
    Emitter<StatisticsState> emit,
  ) {
    emit(
      state.copyWith(
        status: DataLoadingStatus.error,
      ),
    );
  }

  void _onStatisticsSearchPhraseChanged(
    StatisticsSearchPhraseChanged event,
    Emitter<StatisticsState> emit,
  ) {
    final filteredExerciseKeys = _getFilteredExerciseKeys(
      searchPhrase: event.searchPhrase,
    );
    emit(
      state.copyWith(
        visibleExerciseKeys: filteredExerciseKeys,
      ),
    );
  }

  List<String> _getFilteredExerciseKeys({
    String? searchPhrase,
    Map<String, Exercise>? exercises,
    UserStats? userStats,
  }) {
    final _searchPhrase = searchPhrase ?? state.searchPhrase;
    final _exercises = exercises ?? state.exercises;
    final _userStats = userStats ?? state.userStats;

    if (_userStats == null || _userStats.exercisesStats.isEmpty) {
      return [];
    }

    if (_searchPhrase.isEmpty) {
      return _userStats.exercisesStats.keys.toList();
    }

    return _userStats.exercisesStats.keys
        .where(
          (key) => _exercises[key]!
              .name
              .toLowerCase()
              .contains(_searchPhrase.toLowerCase()),
        )
        .toList();
  }

  @override
  Future<void> close() {
    _userStatsSubscription.cancel();
    return super.close();
  }
}
