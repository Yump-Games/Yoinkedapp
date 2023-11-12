import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/food_diary_model.dart';
import 'screens/home.dart';
import 'screens/food_diary.dart';
import 'screens/progress.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yoinked',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FoodDiaryModel()),
        ],
        child: const AppNavigator(),
      ),
    );
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: AppBottomNavigationBar(),
      ),
    );
  }
}

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  AppBottomNavigationBarState createState() => AppBottomNavigationBarState();
}

class AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    FoodDiaryScreen(),
    ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
