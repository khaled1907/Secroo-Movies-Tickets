import 'package:final_project/Main/mainScreen.dart';
import 'package:final_project/core/constans/app_colores.dart';
import 'package:final_project/features/auth/login/login.dart';
import 'package:final_project/sharedPrefrences/shared_prefrences.dart';
import 'package:flutter/material.dart';

class CinemaApp extends StatefulWidget {
  const CinemaApp({super.key});

  @override
  State<CinemaApp> createState() => _CinemaAppState();
}

class _CinemaAppState extends State<CinemaApp> {
  bool isLoggedIn = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    Map<String, dynamic>? userDetails =
        await SharedPreferencesClass.getUserDetails();

    setState(() {
      isLoggedIn = userDetails != null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColores.backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Cinema App',
      home: isLoggedIn ? MainScreen() : LoginScreen(),
    );
  }
}
