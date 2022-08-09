import 'package:animations/animations.dart';
import 'package:api_models/api_models.dart';
import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/app/app.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/l10n/l10n.dart';
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
    const Scaffold(
      body: Center(child: Text('Calendar')),
    ),
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
      body: PageTransitionSwitcher(
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
      bottomNavigationBar: AppBottomNavigationBar(
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
            icon: Assets.icons.icMenuHistory.svg(
              color: iconColor(2),
            ),
            label: l10n.menuItemCalendar,
          ),
          AppMenuItem(
            icon: Assets.icons.icMenuPlans.svg(
              color: iconColor(3),
            ),
            label: l10n.menuItemPlans,
          ),
        ],
      ),
    );
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
                onPressed: () {
                  context.read<AuthenticationClient>().signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
