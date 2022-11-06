import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/blocs/blocs.dart';
import 'package:fitts/workouts/view/workout_log_details.dart';
import 'package:fitts/workouts/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_repository/workouts_repository.dart';

/// {@template workout_history_page}
/// Page that displays the list of all WorkoutLogs.
/// {@endtemplate}
class WorkoutHistoryPage extends StatelessWidget {
  /// {@macro workout_history_page}
  const WorkoutHistoryPage({Key? key}) : super(key: key);

  /// Page helper for creating pages.
  static Page<void> page() {
    return const MaterialPage<void>(child: WorkoutHistoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkoutHistoryBloc(
        workoutsRepository: context.read<WorkoutsRepository>(),
      )..add(const WorkoutLogsSubscriptionRequested()),
      child: const _WorkoutHistoryPageView(),
    );
  }
}

class _WorkoutHistoryPageView extends StatelessWidget {
  const _WorkoutHistoryPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WorkoutHistoryBloc>().state;

    if (state.status == DataLoadingStatus.loading ||
        state.status == DataLoadingStatus.initial) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state.status == DataLoadingStatus.error) {
      return const Scaffold(
        body: Center(
          child: Text('Placeholder for error screen'),
        ),
      );
    }

    return const _WorkoutHistoryContent();
  }
}

class _WorkoutHistoryContent extends StatefulWidget {
  const _WorkoutHistoryContent({
    Key? key,
  }) : super(key: key);

  @override
  State<_WorkoutHistoryContent> createState() => _WorkoutHistoryContentState();
}

class _WorkoutHistoryContentState extends State<_WorkoutHistoryContent>
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
    final workoutLogsHistory =
        context.watch<WorkoutHistoryBloc>().state.workoutLogsHistory;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: context.colorScheme.background,
        title: AnimatedBuilder(
          animation: _colorTween,
          builder: (_, __) => Text(
            'Workout History',
            style: TextStyle(color: _colorTween.value),
          ),
        ),
      ),
      body: workoutLogsHistory == null || workoutLogsHistory.isEmpty
          ? const Center(
              child: Text('No logs to display'),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: const _WorkoutLogs(),
            ),
    );
  }
}

class _WorkoutLogs extends StatelessWidget {
  const _WorkoutLogs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutLogsHistory =
        context.watch<WorkoutHistoryBloc>().state.workoutLogsHistory!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
          ),
          child: Text(
            'Workout History',
            style: context.textTheme.headline3,
          ),
        ),
        for (final workoutLog in workoutLogsHistory)
          _WorkoutLogItem(workoutLog: workoutLog),
      ],
    );
  }
}

class _WorkoutLogItem extends StatelessWidget {
  const _WorkoutLogItem({
    Key? key,
    required this.workoutLog,
  }) : super(key: key);

  final WorkoutLog workoutLog;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxs,
        vertical: AppSpacing.xxxs,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          HapticFeedback.lightImpact();

          Navigator.of(context).push(
            WorkoutLogDetails.route(workoutLog),
          );
        },
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                right: AppSpacing.xs,
              ),
              leading: WorkoutDateChip(date: workoutLog.datePerformed),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateTimeFormatters.monthDayYearTime(
                      workoutLog.datePerformed,
                    ),
                    style: theme.textTheme.bodyText2,
                  ),
                  const AppGap.xxs(),
                  Text(
                    workoutLog.workoutTemplate.name,
                    style: theme.textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Exercises completed: ${workoutLog.exercises.length}',
                    style: theme.textTheme.bodyText1,
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      ),
    );
  }
}
