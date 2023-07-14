import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/splash_screen.dart';
import 'OnBoardPages/onBoardPlansScreen/Pages/firstOpeningPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
  Firebase.initializeApp();
  await Future.delayed(Duration(milliseconds: 3500));

  runApp(const MaterialApp(
    home: FirstOpeningPage(),
  ));
}
