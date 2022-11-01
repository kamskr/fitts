import 'dart:async';

import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    required UserStatsRepository userStatsRepository,
  })  : _userStatsRepository = userStatsRepository,
        super(const StatisticsState()) {
    on<StatisticsChanged>(_onStatisticsChanged);
    on<StatisticsLoadingError>(_onStatisticsLoadingError);
    _userStatsSubscription = _userStatsRepository.userStats.handleError((_) {
      add(StatisticsLoadingError(Exception('Failed to load user stats')));
    }).listen((userStats) => add(StatisticsChanged(userStats)));
  }

  final UserStatsRepository _userStatsRepository;

  late StreamSubscription<UserStats?> _userStatsSubscription;

  void _onStatisticsChanged(
    StatisticsChanged event,
    Emitter<StatisticsState> emit,
  ) {
    emit(
      state.copyWith(
        userStats: event.userStats,
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

  @override
  Future<void> close() {
    _userStatsSubscription.cancel();
    return super.close();
  }
}
