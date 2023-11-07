import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:yoinkedapp/firebase_options.dart';
import 'package:yoinkedapp/goals.dart';
import 'package:yoinkedapp/home.dart';
import 'package:yoinkedapp/progress.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainNavigation());
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.check_box),
            icon: Icon(Icons.check_box_outlined),
            label: 'Goals',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.trending_up),
            icon: Icon(Icons.trending_up_outlined),
            label: 'Progress',
          ),
        ],
      ),
      body: <Widget>[
        HomeScreen(),
        GoalsScreen(),
        ProgressScreen(),
      ][currentPageIndex],
    );
  }
}
