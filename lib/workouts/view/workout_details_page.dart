import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_repository/workouts_repository.dart';

/// {@template workout_details_page}
/// Page that displays the details of a WorkoutTemplate.
/// {@endtemplate}
class WorkoutDetailsPage extends StatelessWidget {
  /// {@macro workout_details_page}
  const WorkoutDetailsPage(
    this.workoutTemplateId, {
    Key? key,
  }) : super(key: key);

  /// Route helper.
  static Route<dynamic> route(String workoutTemplateId) =>
      MaterialPageRoute<void>(
        builder: (_) => WorkoutDetailsPage(workoutTemplateId),
      );

  /// ID of the current workout template.
  final String workoutTemplateId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutDetailsBloc>(
      create: (_) => WorkoutDetailsBloc(
        workoutTemplateId: workoutTemplateId,
        workoutsRepository: context.read<WorkoutsRepository>(),
      )..add(const WorkoutTemplateSubscriptionRequested()),
      child: const _WorkoutDetailsView(),
    );
  }
}

class _WorkoutDetailsView extends StatelessWidget {
  const _WorkoutDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WorkoutDetailsBloc>().state;

    if (state.status == DataLoadingStatus.loading ||
        state.status == DataLoadingStatus.initial) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _WorkoutDetailsContent(state: state);
  }
}

class _WorkoutDetailsContent extends StatefulWidget {
  const _WorkoutDetailsContent({
    Key? key,
    required this.state,
  }) : super(key: key);

  final WorkoutDetailsState state;

  @override
  State<_WorkoutDetailsContent> createState() => _WorkoutDetailsContentState();
}

class _WorkoutDetailsContentState extends State<_WorkoutDetailsContent>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  Color _appColor = Colors.transparent;

  late AnimationController _animationController;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);

    _scrollController.addListener(onScroll);
    super.initState();
  }

  void onScroll() {
    if (_scrollController.position.pixels < 50) {
      _animationController.reverse();
      setState(() {
        _appColor = Colors.transparent;
      });
    } else if (_scrollController.position.pixels > 100) {
      _animationController.forward();
      setState(() {
        _appColor = Colors.white;
      });
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
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _colorTween,
          builder: (_, __) => Text(
            widget.state.workoutTemplate?.name ?? '',
            style: TextStyle(color: _colorTween.value),
          ),
        ),
        backgroundColor: _appColor,
      ),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _WorkoutCardPersistentHeader(),
          ),
          const _WorkoutStats(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: AppSpacing.md,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Text(
                'EXERCISES',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          ...widget.state.workoutTemplate!.exercises
              .asMap()
              .entries
              .map((exerciseItem) {
            final exercise = exerciseItem.value;
            final index = exerciseItem.key;
            return SliverToBoxAdapter(
              child: ExerciseCard(
                exercise: exercise,
                exerciseIndex: index,
                exerciseCount: widget.state.workoutTemplate!.exercises.length,
              ),
            );
          }).toList(),
          if (widget.state.workoutTemplate!.exercises.length < 2)
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 300,
              ),
            ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutCardPersistentHeader extends SliverPersistentHeaderDelegate {
  _WorkoutCardPersistentHeader();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final workoutTemplate =
        context.watch<WorkoutDetailsBloc>().state.workoutTemplate!;

    final percent = shrinkOffset / maxExtent;
    final l10n = context.l10n;

    return Column(
      children: [
        Expanded(
          child: Opacity(
            opacity: max(0, 1 - 3 * percent),
            child: WorkoutCard(
              workoutTemplate: workoutTemplate,
              header: shrinkOffset <= 200
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).padding.top,
                        ),
                        if (workoutTemplate.lastPerformed != null)
                          Text(
                            l10n.homePagePreviousWorkoutDate(
                              DateTimeFormatters.weekdayMonthDay(
                                workoutTemplate.lastPerformed!,
                              ),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                      ],
                    )
                  : const SizedBox(),
              footer: const SizedBox(),
              radius: 0,
              height: max(
                370 * (1 - percent),
                MediaQuery.of(context).padding.top,
              ),
            ),
          ),
        ),
        AppButton.gradient(
          height: max(60, 100 * (1 - percent)),
          child: const Text('START'),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  double get maxExtent => 460;

  @override
  double get minExtent => 164;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _WorkoutStats extends StatelessWidget {
  const _WorkoutStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutTemplate =
        context.watch<WorkoutDetailsBloc>().state.workoutTemplate!;
    final totalKg = workoutTemplate.tonnageLifted;
    final iconColor = Theme.of(context).colorScheme.primary;
    const iconHeight = 22.0;

    late String totalKgString;

    if (totalKg < 1000) {
      totalKgString = totalKg.toString();
    } else {
      totalKgString = '${(totalKg / 1000).round()}k';
    }

    return SliverToBoxAdapter(
      child: WorkoutStatsGrid(
        workoutStats: [
          WorkoutStatGridItem(
            icon: Assets.icons.icTonnageLifted.svg(
              color: iconColor,
              height: iconHeight,
            ),
            title: workoutTemplate.workoutsCompleted.toString(),
            subtitle: 'workouts completed',
          ),
          WorkoutStatGridItem(
            icon: Assets.icons.icWorkoutsCompleted.svg(
              color: iconColor,
              height: iconHeight,
            ),
            title: totalKgString,
            subtitle: 'tonnage lifted',
            titleSuffix: 'kg',
          ),
          WorkoutStatGridItem(
            icon: Assets.icons.icRestTime.svg(
              color: iconColor,
              height: iconHeight,
            ),
            title: DateTimeFormatters.formatSeconds(
              workoutTemplate.lastAverageRestTime ?? 0,
            ),
            subtitle: 'avg. rest time',
            titleSuffix: 'min',
          ),
          WorkoutStatGridItem(
            icon: Assets.icons.icDuration.svg(
              color: iconColor,
              height: iconHeight,
            ),
            title: DateTimeFormatters.formatSeconds(
              workoutTemplate.averageWorkoutLength ?? 0,
            ),
            subtitle: 'avg. workout length',
            titleSuffix: 'h',
          ),
        ],
      ),
    );
  }
}
