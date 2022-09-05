import 'package:app_ui/app_ui.dart';
import 'package:fitts/app/bloc/app_bloc.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:user_stats_repository/user_stats_repository.dart';

// todo(kamskry): TEMP FLAGS TO BE REMOVED AND REPLACED WITH REAL CONDITIONS
const bool _workoutsExist = true;
const bool _previousWorkoutExists = true;

/// {@template home_page}
///  Dashboard view of the application.
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({Key? key}) : super(key: key);

  /// Page helper for creating pages.
  static Page<void> page() {
    return const MaterialPage<void>(child: HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        userStatsRepository: context.read<UserStatsRepository>(),
      )..add(const UserStatsSubscriptionRequested()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: const SafeArea(
        child: _HomeBody(),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;

    if (state is HomeInitialState) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is HomeErrorState) {
      return const Scaffold(
        body: Center(
          child: Text('Placeholder for error screen.'),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: const [
          _HomeHeader(),
          AppGap.lg(),
          Divider(height: 1),
          _DashboardStats(),
          Divider(height: 1),
          AppGap.md(),
          if (_previousWorkoutExists) ...[
            _PreviousWorkout(),
            AppGap.md(),
            Divider(height: 1),
          ],
          if (_workoutsExist) ...[
            AppGap.xs(),
            _UserWorkouts(),
          ],
          if (!_workoutsExist) ...[
            AppGap.xs(),
            _EmptyWorkouts(),
          ],
        ],
      ),
    );
  }
}

class _DashboardStats extends StatelessWidget {
  const _DashboardStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final userProfile = context.watch<AppBloc>().state.userProfile;
    final userStats =
        (context.watch<HomeBloc>().state as HomeSuccessState).userStats;

    final totalKg = userStats.globalStats.totalKgLifted;
    late String totalKgString;

    if (totalKg < 1000) {
      totalKgString = totalKg.toString();
    } else {
      totalKgString = '${(totalKg / 1000).round()}k';
    }

    return Row(
      children: [
        _DashboardStatsItem(
          count: userStats.globalStats.workoutsCompleted.toString(),
          titlePart1: l10n.homePageWorkoutsCompleted1,
          titlePart2: l10n.homePageWorkoutsCompleted2,
        ),
        _DashboardStatsItem(
          count: totalKgString,
          suffix: 'kg',
          titlePart1: l10n.homePageTonnageLifted1,
          titlePart2: l10n.homePageTonnageLifted2,
        ),
        _DashboardStatsItem(
          count: '${userProfile.weight}',
          suffix: 'kg',
          titlePart1: l10n.homePageCurrentWeight1,
          titlePart2: l10n.homePageCurrentWeight2,
          showBorder: false,
        ),
      ],
    );
  }
}

class _DashboardStatsItem extends StatelessWidget {
  const _DashboardStatsItem({
    Key? key,
    required this.count,
    required this.titlePart1,
    required this.titlePart2,
    this.showBorder = true,
    this.suffix,
  }) : super(key: key);

  final String count;
  final String titlePart1;
  final String titlePart2;
  final bool showBorder;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: showBorder
                ? Border(
                    right: BorderSide(
                      color: Theme.of(context)
                          .extension<AppColorScheme>()!
                          .black100,
                    ),
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.md,
              left: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      count,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    if (suffix != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppSpacing.xxxs,
                          bottom: AppSpacing.xxs,
                        ),
                        child: Text(
                          suffix!,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                  ],
                ),
                const AppGap.xxxs(),
                Text(
                  titlePart1,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  titlePart2,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final userProfile = context.watch<AppBloc>().state.userProfile;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.homePageTitle,
            style: theme.textTheme.headline3,
          ),
          _SmallAvatar(photoUrl: userProfile.photoUrl),
        ],
      ),
    );
  }
}

class _SmallAvatar extends StatelessWidget {
  const _SmallAvatar({
    Key? key,
    required this.photoUrl,
  }) : super(key: key);

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.xxxs),
        child: SizedBox(
          height: 40,
          width: 40,
          child: photoUrl != ''
              ? Image.network(
                  photoUrl,
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                )
              : Assets.icons.emptyProfileImage.svg(),
        ),
      ),
    );
  }
}

class _PreviousWorkout extends StatelessWidget {
  const _PreviousWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 58,
                  width: 39,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '22',
                        style: theme.textTheme.headline6!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'MAY',
                        style: theme.textTheme.overline!.copyWith(
                          color: Colors.white.withOpacity(.6),
                        ),
                      ),
                    ],
                  ),
                ),
                const AppGap.md(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.homePagePreviousWorkoutLabel,
                      style: theme.textTheme.bodyText2,
                    ),
                    const AppGap.xxs(),
                    Text(
                      'Quads & Deltoids',
                      style: theme.textTheme.headline6,
                    ),
                    Text(
                      l10n.homePagePreviousWorkoutExercisesCount(7),
                      style: theme.textTheme.bodyText1,
                    ),
                  ],
                ),
              ],
            ),
            Assets.icons.icChevronRight.svg(),
          ],
        ),
      ),
    );
  }
}

class _EmptyWorkouts extends StatelessWidget {
  const _EmptyWorkouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/home/empty_dashboard.svg',
                semanticsLabel: 'Empty workouts',
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(0, 255, 255, 255),
                        Theme.of(context).colorScheme.background,
                      ],
                      stops: const [.1, .8],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const AppGap.md(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xlg,
          ),
          child: Text(
            l10n.homePageNoWorkoutsMessage,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        const AppGap.md(),
        SizedBox(
          height: 48,
          width: 210,
          child: AppButton.gradient(
            onPressed: () {},
            child: Text(l10n.homePageCreateWorkoutButtonText),
          ),
        ),
      ],
    );
  }
}

class _UserWorkouts extends StatelessWidget {
  const _UserWorkouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.homePageNextWorkoutLabel,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              AppTextButton(
                onPressed: () {},
                textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                child: Text(l10n.homePageShowAllWorkouts),
              ),
            ],
          ),
          SizedBox(
            height: 290,
            width: double.infinity,
            child: AppChartCard(
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chest & Back',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  Text(
                    l10n.homePagePreviousWorkoutDate('Mon, May 8'),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
              values: const [
                5,
                16,
                14,
                12,
                5,
                16,
                // 5, 5, 5, 5, 5, 5
              ],
              footer: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '7',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          Text(
                            l10n.homePageNextWorkoutTimesCompleted,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 46,
                        child: AppButton.gradient(
                          child: Text(l10n.homePageStartWorkoutButtonText),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
