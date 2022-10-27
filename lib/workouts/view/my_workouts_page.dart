import 'package:app_ui/app_ui.dart';
import 'package:fitts/utils/utils.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_repository/workouts_repository.dart';

/// {@template my_workouts_page}
/// Page with list of user's workout templates.
/// {@endtemplate}
class MyWorkoutsPage extends StatelessWidget {
  /// {@macro my_workouts_page}
  const MyWorkoutsPage({Key? key}) : super(key: key);

  /// Route helper for creating routes.
  static Route<dynamic> route() =>
      MaterialPageRoute<void>(builder: (_) => const MyWorkoutsPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyWorkoutsBloc(
        workoutsRepository: context.read<WorkoutsRepository>(),
      )..add(const WorkoutTemplatesSubscriptionRequested()),
      child: const _MyWorkoutsPageView(),
    );
  }
}

class _MyWorkoutsPageView extends StatefulWidget {
  const _MyWorkoutsPageView({Key? key}) : super(key: key);

  @override
  State<_MyWorkoutsPageView> createState() => _MyWorkoutsPageViewState();
}

class _MyWorkoutsPageViewState extends State<_MyWorkoutsPageView>
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

    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
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
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _colorTween,
          builder: (_, __) => Text(
            'My Workouts',
            style: TextStyle(color: _colorTween.value),
          ),
        ),
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              HapticFeedback.lightImpact();

              Navigator.of(context).push(
                WorkoutCreatorPage.route(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: const _MyWorkoutsBody(),
      ),
    );
  }
}

class _MyWorkoutsBody extends StatelessWidget {
  const _MyWorkoutsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MyWorkoutsBloc>().state;

    if (state.status == DataLoadingStatus.loading ||
        state.status == DataLoadingStatus.initial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.status == DataLoadingStatus.error) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppGap.md(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Text(
            'My Workouts',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const AppGap.md(),
        if (state.workoutTemplates != null)
          ...state.workoutTemplates!
              .map(
                (workoutTemplate) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.xs,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        WorkoutDetailsPage.route(workoutTemplate.id),
                      );
                    },
                    child: WorkoutCard(
                      workoutTemplate: workoutTemplate,
                    ),
                  ),
                ),
              )
              .toList(),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
