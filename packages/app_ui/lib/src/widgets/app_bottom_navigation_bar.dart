import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppMenuItem {
  const AppMenuItem({
    required this.icon,
    required this.label,
  });

  final Widget icon;
  final String label;
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.menuItems,
    required this.currentIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final List<AppMenuItem> menuItems;
  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      items: menuItems
          .map((menuItem) => BottomNavigationBarItem(
                icon: menuItem.icon,
                label: menuItem.label,
              ))
          .toList(),
      selectedItemColor: AppColors.black,
      currentIndex: currentIndex,
      onTap: (index) {
        HapticFeedback.lightImpact();
        onTap.call(index);
      },
    );
  }
}
