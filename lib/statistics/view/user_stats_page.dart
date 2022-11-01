import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/app/bloc/app_bloc.dart';
import 'package:fitts/statistics/statistics.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:user_stats_repository/user_stats_repository.dart';

/// {@template user_stats_page}
/// Page that displays the user's statistics.
/// {@endtemplate}
class UserStatsPage extends StatelessWidget {
  /// {@macro user_stats_page}
  const UserStatsPage({Key? key}) : super(key: key);

  /// Route helper.
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => const UserStatsPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisticsBloc>(
      create: (_) => StatisticsBloc(
        userStatsRepository: context.read<UserStatsRepository>(),
      ),
      child: const _UserStatsView(),
    );
  }
}

class _UserStatsView extends StatelessWidget {
  const _UserStatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StatisticsBloc>().state;

    if (state.status == DataLoadingStatus.loading ||
        state.status == DataLoadingStatus.initial) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return const _UserStatsContent();
  }
}

class _UserStatsContent extends StatefulWidget {
  const _UserStatsContent({
    Key? key,
  }) : super(key: key);

  @override
  State<_UserStatsContent> createState() => _UserStatsContentState();
}

class _UserStatsContentState extends State<_UserStatsContent>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.black)
        .animate(_animationController);

    _scrollController.addListener(onScroll);
    super.initState();
  }

  void onScroll() {
    if (_scrollController.position.pixels < 50) {
      _animationController.reverse();
    } else if (_scrollController.position.pixels > 50) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.removeListener(onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userStats = context.watch<StatisticsBloc>().state.userStats;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 1,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: AnimatedBuilder(
            animation: _colorTween,
            builder: (_, __) => Text(
              'Statistics',
              style: TextStyle(color: _colorTween.value),
            ),
          ),
        ),
        body: userStats == null
            ? const Center(
                child: Text('No logs to display'),
              )
            : NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, value) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Text(
                          'Statistics',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                    SliverPinnedHeader(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                        ),
                        child: TabBar(
                          labelColor:
                              Theme.of(context).colorScheme.onBackground,
                          indicatorColor: Theme.of(context).colorScheme.primary,
                          tabs: const [
                            Tab(
                              text: 'Global stats',
                            ),
                            Tab(
                              text: 'Exercise specific',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: const SizedBox(
                  child: TabBarView(
                    children: [
                      _UserStats(),
                      Center(
                        child: Text('Exercise specific'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _UserStats extends StatelessWidget {
  const _UserStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _GeneralStats(),
          AppGap.md(),
          _KeyLifts(),
        ],
      ),
    );
  }
}

class _GeneralStats extends StatelessWidget {
  const _GeneralStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfile = context.watch<AppBloc>().state.userProfile;
    final userStats = context.watch<StatisticsBloc>().state.userStats!;
    final totalKg = userStats.globalStats.totalKgLifted;
    final iconColor = Theme.of(context).colorScheme.primary;
    const iconHeight = 22.0;

    late String totalKgString;

    if (totalKg < 1000) {
      totalKgString = totalKg.toString();
    } else {
      totalKgString = '${(totalKg / 1000).round()}k';
    }

    return WorkoutStatsGrid(
      workoutStats: [
        WorkoutStatGridItem(
          icon: Assets.icons.icWorkoutsCompleted.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: userStats.globalStats.workoutsCompleted.toString(),
          subtitle: 'workouts completed',
        ),
        WorkoutStatGridItem(
          icon: Assets.icons.icTonnageLifted.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: totalKgString,
          subtitle: 'tonnage lifted',
          titleSuffix: 'kg',
        ),
        WorkoutStatGridItem(
          icon: Assets.icons.icTime.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: DateTimeFormatters.formatSeconds(
            userStats.globalStats.liftingTimeSpent,
          ),
          subtitle: 'lifting time spent',
          titleSuffix: 'h',
        ),
        WorkoutStatGridItem(
          icon: Assets.icons.icWeigh.svg(
            color: iconColor,
            height: iconHeight,
          ),
          title: userProfile.weight.toString(),
          subtitle: 'current weight',
          titleSuffix: 'kg',
        ),
      ],
    );
  }
}

class _KeyLifts extends StatelessWidget {
  const _KeyLifts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userStats = context.watch<StatisticsBloc>().state.userStats!;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'KEY LIFTS OVERALL BEST',
            style: Theme.of(context).textTheme.caption,
          ),
          for (String exerciseKey in userStats.globalStats.keyLifts) ...[
            const AppGap.md(),
            _KeyLiftCard(
              exerciseKey: exerciseKey,
            ),
          ],
        ],
      ),
    );
  }
}

class _KeyLiftCard extends StatelessWidget {
  const _KeyLiftCard({
    Key? key,
    required this.exerciseKey,
  }) : super(key: key);

  final String exerciseKey;

  @override
  Widget build(BuildContext context) {
    final userStats = context.watch<StatisticsBloc>().state.userStats!;
    final exerciseStats = userStats.exercisesStats[exerciseKey];
    final exercise = context.read<Map<String, Exercise>>()[exerciseKey];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.xxxs),
        gradient:
            Theme.of(context).extension<AppColorScheme>()!.primaryGradient2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            exercise?.name ?? 'This exercise does not exist',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          const AppGap.md(),
          if (exerciseStats == null)
            Center(
              child: Text(
                'no data',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          else
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        exerciseStats.overallBest.weight.toString(),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      Text(
                        'kg',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.8),
                            ),
                      ),
                    ],
                  ),
                  Text(
                    '*',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  Column(
                    children: [
                      Text(
                        exerciseStats.overallBest.repetitions.toString(),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      Text(
                        'reps',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.8),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
