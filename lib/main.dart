import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/MoneyMateNewDesignPages/onBoardPlansScreen/Pages/firstOpeningPage.dart';
import 'package:moneymate/splash_screen.dart';

Future<void> main() async {
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
  Firebase.initializeApp();
  await Future.delayed(Duration(milliseconds: 3500));

  runApp(const MaterialApp(
    home: FirstOpeningPage(),
  ));
}
