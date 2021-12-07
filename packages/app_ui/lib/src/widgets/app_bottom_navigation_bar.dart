import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.menuItems,
    required this.currentIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final List<String> menuItems;
  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      items: menuItems
          .map((menuItem) => BottomNavigationBarItem(
                icon: const Icon(Icons.ac_unit),
                label: menuItem,
              ))
          .toList(),
      selectedItemColor: AppColors.black,
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
