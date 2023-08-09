import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/Utils/firebase_manager.dart';
import 'package:moneymate/addPlanPage/Page/add_plan_page.dart';
import 'package:moneymate/homePage/Page/savings_account_details_page.dart';

import 'splash_screen.dart';

// ... diğer import bildirimleri ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
  Firebase.initializeApp();
  await handleAppStart();
}

Future<void> handleAppStart() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
    final Map<String, dynamic> mapSaveData =
        Platform.isIOS ? {'Platform': 'iOS'} : {'Platform': 'Android'};

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(mapSaveData);
  }
  await FBManager.updatePlanList();

  valueNotifierX.value += 1;

  runApp(MaterialApp(
    home: getdataList.isNotEmpty
        ? SavingsAccountDetailsPage(
            savingsAccount: savingsAccounts.first,
          )
        : AddPlanPage(),
  ));
}
