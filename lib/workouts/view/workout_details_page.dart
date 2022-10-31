import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
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

    return _WorkoutDetailsListener(child: _WorkoutDetailsContent(state: state));
  }
}

class _WorkoutDetailsListener extends StatelessWidget {
  const _WorkoutDetailsListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutDetailsBloc, WorkoutDetailsState>(
      listener: (context, state) {
        if (state.deleteStatus == FormzStatus.submissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: child,
    );
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
  late Animation<Color?> _textColorTween;
  late Animation<Color?> _actionsColorTween;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _textColorTween = ColorTween(
      begin: Theme.of(context).colorScheme.onPrimary,
      end: Theme.of(context).colorScheme.onBackground,
    ).animate(_animationController);

    _actionsColorTween = ColorTween(
      begin: Theme.of(context).colorScheme.onPrimary,
      end: Theme.of(context).colorScheme.primary,
    ).animate(_animationController);

    _scrollController.addListener(onScroll);
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
        foregroundColor: _textColorTween.value,
        iconTheme: IconThemeData(color: _actionsColorTween.value),
        title: AnimatedBuilder(
          animation: _textColorTween,
          builder: (_, __) => Text(
            widget.state.workoutTemplate?.name ?? '',
            style: TextStyle(color: _textColorTween.value),
          ),
        ),
        backgroundColor: _appColor,
        actions: [
          AppTextButton(
            textStyle: Theme.of(context).textTheme.bodyText1,
            textColor: _actionsColorTween.value,
            child: const Text(
              'Edit',
            ),
            onPressed: () {
              final workoutTemplate =
                  context.read<WorkoutDetailsBloc>().state.workoutTemplate;

              Navigator.of(context).push(
                WorkoutCreatorPage.route(workoutTemplate: workoutTemplate),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _WorkoutCardPersistentHeader(
              minHeight: kToolbarHeight +
                  MediaQuery.of(context).padding.top +
                  _minStartButtonHeight,
            ),
          ),
          const _WorkoutStats(),
          const SliverToBoxAdapter(
            child: _WorkoutNotes(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: AppSpacing.md,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
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
                exerciseCardData: ExerciseCardData(
                  exercise: exercise,
                  exerciseIndex: index,
                  exerciseCount: widget.state.workoutTemplate!.exercises.length,
                ),
              ),
            );
          }).toList(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: AppSpacing.md,
            ),
          ),
          const _DeleteWorkoutButton(),
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

const _minStartButtonHeight = 64.0;
const _maxContentHeight = 370.0;

class _WorkoutCardPersistentHeader extends SliverPersistentHeaderDelegate {
  _WorkoutCardPersistentHeader({required this.minHeight});

  final double minHeight;

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
                              DateTimeFormatters.weekdayMonthDayHour(
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
                _maxContentHeight * (1 - percent),
                MediaQuery.of(context).padding.top,
              ),
            ),
          ),
        ),
        AppButton.gradient(
          height: max(_minStartButtonHeight, 100 * (1 - percent)),
          onPressed: context.watch<WorkoutTrainingBloc>().state
                  is! WorkoutTrainingInProgress
              ? () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  context.read<WorkoutTrainingBloc>().add(
                        WorkoutTrainingStart(
                          workoutTemplate: workoutTemplate,
                        ),
                      );
                }
              : null,
          child: const Text('START'),
        )
      ],
    );
  }

  @override
  double get maxExtent => 460;

  @override
  double get minExtent => minHeight;

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
              showHours: false,
              showSeconds: true,
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

class _WorkoutNotes extends StatelessWidget {
  const _WorkoutNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutTemplate =
        context.watch<WorkoutDetailsBloc>().state.workoutTemplate!;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'NOTES',
            style: Theme.of(context).textTheme.caption,
          ),
          const AppGap.sm(),
          Text(workoutTemplate.notes),
        ],
      ),
    );
  }
}

class _DeleteWorkoutButton extends StatelessWidget {
  const _DeleteWorkoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppTextButton(
        textColor: Theme.of(context).colorScheme.error,
        child: const Text('Delete Workout'),
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              final alert = AlertDialog(
                title: const Text('Delete Workout Template'),
                content: const Text(
                  'Are you sure you want to delete this workout?'
                  ' This action cannot be undone.',
                ),
                actions: [
                  AppTextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                  const _ConfirmDeleteWorkoutTemplateButton(),
                ],
              );

              return BlocProvider.value(
                value: context.watch<WorkoutDetailsBloc>(),
                child: alert,
              );
            },
          );
        },
      ),
    );
  }
}

class _ConfirmDeleteWorkoutTemplateButton extends StatelessWidget {
  const _ConfirmDeleteWorkoutTemplateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutDetailsBloc, WorkoutDetailsState>(
      listener: (context, state) {
        if (state.deleteStatus.isSubmissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state.deleteStatus.isSubmissionInProgress) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
        }
        return AppTextButton(
          textColor: Theme.of(context).colorScheme.error,
          onPressed: () {
            context.read<WorkoutDetailsBloc>().add(
                  const WorkoutTemplateDeleteTemplate(),
                );
          },
          child: const Text('Yes'),
        );
      },
    );
  }
}
