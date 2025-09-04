// lib/screens/main_navigation_screen.dart

import 'package:flutter/material.dart';
import 'package:maturity_model/maturity_model.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // Calculate responsive icon size based on text scale
    final baseSpacing = textTheme.bodyMedium!.fontSize!;
    final iconSize =
        baseSpacing * 2.0; // 32px mobile, 48px tablet, 64px desktop

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeScreen(),
          const ResultsScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: iconSize),
            selectedIcon: Icon(Icons.home, size: iconSize),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined, size: iconSize),
            selectedIcon: Icon(Icons.analytics, size: iconSize),
            label: 'Results',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, size: iconSize),
            selectedIcon: Icon(Icons.settings, size: iconSize),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
