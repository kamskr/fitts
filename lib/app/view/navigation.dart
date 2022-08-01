import 'package:animations/animations.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// {@template navigation}
/// Widget used for main navigation of the app.
/// It switches between provided pages and implements AppBottomNavigationBar.
/// {@endtemplate}
class Navigation extends StatefulWidget {
  /// {@macro navigation}
  const Navigation({
    Key? key,
  }) : super(key: key);

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
      body: Center(child: Text('Plans')),
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
