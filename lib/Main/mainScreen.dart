import 'package:final_project/features/booked%20films/booked_films.dart';
import 'package:final_project/features/explore/explore.dart';
import 'package:final_project/features/home/home.dart';
import 'package:final_project/features/settings/settings.dart';
import 'package:final_project/sharedWidgets/BottomNavigationBar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget screen;

    switch (currentIndex) {
      case 0:
        screen = Home();
        break;
      case 1:
        screen = Explore();
        break;
      case 2:
        screen = BookedFilms();
        break;
      case 3:
        screen = Settings();
        break;
      default:
        screen = Home();
    }

    return Scaffold(
      body: screen,
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
