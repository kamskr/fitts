import 'package:app_ui/app_ui.dart';
import 'package:fitts/home/home.dart';
import 'package:fitts/l10n/l10n.dart';
import 'package:flutter/material.dart';

import 'widget/fade_indexed_stack.dart';

/// {@template navigation}
/// Widget used for main navigation of the app.
/// It switches between provided pages and implements AppBottomNavigationBar.
/// {@endtemplate}
class Navigation extends StatefulWidget {
  const Navigation({
    Key? key,
  }) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(child: Navigation());
  }

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: FadeIndexedStack(
        index: _selectedIndex,
        children: const <Widget>[
          HomePage(),
          Center(child: Text('Stats')),
          Center(child: Text('Calendar')),
          Center(child: Text('Plans')),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        menuItems: [
          AppMenuItem(
            icon: Assets.icons.icMenuHome.svg(),
            label: l10n.menuItemDashboard,
          ),
          AppMenuItem(
            icon: Assets.icons.icMenuStats.svg(),
            label: l10n.menuItemStats,
          ),
          AppMenuItem(
            icon: Assets.icons.icMenuHistory.svg(),
            label: l10n.menuItemCalendar,
          ),
          AppMenuItem(
            icon: Assets.icons.icMenuPlans.svg(),
            label: l10n.menuItemPlans,
          ),
        ],
      ),
    );
  }
}
