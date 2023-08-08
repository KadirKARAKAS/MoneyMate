import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/addPlanPage/Page/add_plan_page.dart';
import 'package:moneymate/homePage/Page/home_page.dart';

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
  } else {
    // GETDATA LİST ÇEKME İŞLEMİ BAŞLADI
    final userRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Plans")
        .orderBy('createdTime', descending: true);

    final querySnapshot = await userRef.get();
    querySnapshot.docs.forEach((doc) async {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("My Plans")
          .doc(doc.id)
          .update({'docId': doc.id});
      getdataList.add(doc.data() as Map<String, dynamic>);
    });
    final userReff = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Plans");

    final querySnapshott = await userReff.get();

    incomeOrExpenseList.clear();
    await Future.forEach(querySnapshott.docs, (planDoc) async {
      final incomeExpenseRef = planDoc.reference
          .collection("Income&Expense")
          .orderBy('createdTime', descending: true);

      final incomeExpenseSnapshot = await incomeExpenseRef.get();

      incomeExpenseSnapshot.docs.forEach((doc) {
        incomeOrExpenseList.add(doc.data());
      });
    });
  }

  await Future.delayed(
    const Duration(milliseconds: 1000),
    () {
      valueNotifierX.value += 1;

      runApp(MaterialApp(
        home: getdataList.isNotEmpty ? HomePagePlans() : AddPlanPage(),
      ));
    },
  );
}
