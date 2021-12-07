import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar(
      {required this._menuItems, required this._onTap, Key? key})
      : super(key: key);

  final List<String> _menuItems;
  final Function(int) _onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      items: _menuItems
          .map((menuItem) => BottomNavigationBarItem(
                icon: const Icon(Icons.ac_unit),
                label: menuItem,
              ))
          .toList(),
      selectedItemColor: AppColors.black,
      currentIndex: _selectedIndex,
      onTap: _onTap,
    );
  }
}
