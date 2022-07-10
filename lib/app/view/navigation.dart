import 'package:app_ui/app_ui.dart';
import 'package:fitts/home/home.dart';
import 'package:flutter/material.dart';

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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
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
        menuItems: const [
          AppMenuItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          AppMenuItem(
            icon: Icon(Icons.settings),
            label: 'Stats',
          ),
          AppMenuItem(
            icon: Icon(Icons.settings),
            label: 'Calendar',
          ),
          AppMenuItem(
            icon: Icon(Icons.settings),
            label: 'Plans',
          ),
        ],
      ),
    );
  }
}
