import 'dart:async';

import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_stats_repository/user_stats_repository.dart';
import 'package:workouts_repository/workouts_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

/// {@template home_bloc}
/// The bloc responsible for fetching data used by home_page.
/// {@endtemplate}
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// {@macro home_bloc}
  HomeBloc({
    required UserStatsRepository userStatsRepository,
    required WorkoutsRepository workoutsRepository,
  })  : _userStatsRepository = userStatsRepository,
        _workoutsRepository = workoutsRepository,
        super(
          const HomeState(
            status: HomeStatus.initial,
          ),
        ) {
    on<UserStatsSubscriptionRequested>(_onUserStatsSubscriptionRequested);
    on<WorkoutTemplatesSubscriptionRequested>(
      _onWorkoutTemplatesSubscriptionRequested,
    );
  }

  final UserStatsRepository _userStatsRepository;
  final WorkoutsRepository _workoutsRepository;

  Future<void> _onUserStatsSubscriptionRequested(
    UserStatsSubscriptionRequested event,
    Emitter<HomeState> emit,
  ) async {
    await emit.forEach<UserStats?>(
      _userStatsRepository.userStats,
      onData: (userStats) {
        add(const WorkoutTemplatesSubscriptionRequested());
        return state.copyWith(
          userStats: userStats,
          status: HomeStatus.loading,
        );
      },
      onError: (_, __) => state.copyWith(
        status: HomeStatus.error,
      ),
    );
  }

  Future<void> _onWorkoutTemplatesSubscriptionRequested(
    WorkoutTemplatesSubscriptionRequested event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final workoutLog = await _workoutsRepository.getLatestWorkoutLog();

      await emit.forEach<List<WorkoutTemplate>?>(
        _workoutsRepository.getWorkoutTemplates(),
        onData: (workoutTemplates) {
          return state.copyWith(
            workoutTemplates: workoutTemplates,
            status: HomeStatus.success,
            recentWorkoutLog: workoutLog,
          );
        },
        onError: (_, __) => state.copyWith(
          status: HomeStatus.error,
        ),
      );
    } catch (e) {
      state.copyWith(
        status: HomeStatus.error,
      );

      addError(e);
    }
  }
}
