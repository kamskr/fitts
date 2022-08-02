import 'dart:async';

import 'package:api_models/api_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_stats_repository/user_stats_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

/// {@template home_bloc}
/// The bloc responsible for fetching data used by home_page.
/// {@endtemplate}
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// {@macro home_bloc}
  HomeBloc({
    required UserStatsRepository userStatsRepository,
  })  : _userStatsRepository = userStatsRepository,
        super(HomeInitialState()) {
    on<UserStatsSubscriptionRequested>(_onUserStatsSubscriptionRequested);
  }

  final UserStatsRepository _userStatsRepository;

  Future<void> _onUserStatsSubscriptionRequested(
    UserStatsSubscriptionRequested event,
    Emitter<HomeState> emit,
  ) async {
    await emit.forEach<UserStats?>(
      _userStatsRepository.userStats,
      onData: (userStats) => HomeSuccessState(userStats ?? UserStats.empty),
      onError: (_, __) => HomeErrorState(),
    );
  }
}
