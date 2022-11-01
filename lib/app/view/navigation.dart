import 'package:animations/animations.dart';
import 'package:app_models/app_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/app/app.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:fitts/workouts/view/workout_history_page.dart';
import 'package:fitts/workouts/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template navigation}
/// Widget used for main navigation of the app.
/// It switches between provided pages and implements AppBottomNavigationBar.
/// {@endtemplate}
class Navigation extends StatefulWidget {
  /// {@macro navigation}
  const Navigation({Key? key}) : super(key: key);

  /// Page helper for creating pages.
  static Page<void> page() {
    return const MaterialPage<void>(child: Navigation());
  }

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  final _pages = [
    const HomePage(key: PageStorageKey('homePage')),
    const Scaffold(
      body: Center(child: Text('Stats')),
    ),
    const WorkoutHistoryPage(),
    const Scaffold(
      body: _TempPlansWidget(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    Color iconColor(int index) =>
        AppColors.black.withOpacity(_currentIndex == index ? 1 : 0.5);

    return Scaffold(
      body: Stack(
        children: [
          PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return SharedAxisTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                // fillColor: Colors.black,
                child: child,
              );
            },
            child: _pages[_currentIndex],
          ),
          const WorkoutTraining(),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: context.watch<ValueNotifier<double>>(),
        builder: (BuildContext context, double height, Widget? child) {
          final isTraining = context.watch<WorkoutTrainingBloc>().state
              is WorkoutTrainingInProgress;
          final bottomNavBarHeight = kBottomNavigationBarHeight +
              MediaQuery.of(context).padding.bottom;

          final value = isTraining
              ? percentageFromValueInRange(
                  min: kMinMiniplayerHeight,
                  max: maxMiniplayerHeight(context),
                  value: height,
                )
              : 0;

          return SizedBox(
            height: bottomNavBarHeight - bottomNavBarHeight * value,
            child: Transform.translate(
              offset: Offset(0, bottomNavBarHeight * value * 0.5),
              child: OverflowBox(
                maxHeight: bottomNavBarHeight,
                child: child,
              ),
            ),
          );
        },
        child: AppBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          menuItems: [
            AppMenuItem(
              icon: Assets.icons.icMenuHome.svg(
                color: iconColor(0),
              ),
              label: l10n.menuItemDashboard,
            ),
            AppMenuItem(
              icon: Assets.icons.icMenuStats.svg(
                color: iconColor(1),
              ),
              label: l10n.menuItemStats,
            ),
            AppMenuItem(
              icon: Assets.icons.icHistory.svg(
                color: iconColor(2),
              ),
              label: 'History',
            ),
            AppMenuItem(
              icon: Assets.icons.dragIcon.svg(
                color: iconColor(3),
              ),
              label: 'Other',
            ),
          ],
        ),
      ),
    );
  }

  double percentageFromValueInRange({
    required double min,
    required double max,
    required double value,
  }) {
    return (value - min) / (max - min);
  }
}

class _TempPlansWidget extends StatelessWidget {
  const _TempPlansWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppBloc>().state;

    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.userProfile.profileStatus == ProfileStatus.active
                  ? 'User active'
                  : 'User not active',
            ),
            Text(state.userProfile.email),
            Text(state.userProfile.displayName),
            Text(state.userProfile.gender == Gender.male ? 'Male' : 'Female'),
            Text(state.userProfile.height.toString()),
            Text(state.userProfile.weight.toString()),
            Center(
              child: AppButton.primary(
                child: const Text('Sign out'),
                onPressed: () => context.read<AuthenticationClient>().signOut(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
