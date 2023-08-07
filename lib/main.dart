import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/addPlanPage/Page/add_plan_page.dart';
import 'package:moneymate/expense&incomePage/Page/expense_income_page.dart';
import 'package:moneymate/homePage/Page/home_page.dart';

import 'splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
  Firebase.initializeApp();
  await Future.delayed(const Duration(milliseconds: 3500));
  handleAppStart();
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

    runApp(const MaterialApp(
      home: AddPlanPage(),
    ));
  } else {
    //GETDATA LİST ÇEKME İŞLEMİ BAŞLADI
    final userRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Plans")
        .orderBy('createdTime', descending: true);

    final querySnapshot = await userRef.get();
    getdataList.clear();
    querySnapshot.docs.forEach((doc) async {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("My Plans")
          .doc(doc.id)
          .update({'docId': doc.id});
      getdataList.add(doc.data());
    });
    Future.delayed(
      const Duration(seconds: 2),
      () {
        print("2SANİYE BEKLENİYOR");
        getdataList.isEmpty
            ? runApp(const MaterialApp(
                home: ExpenseIncomePage(),
              ))
            : runApp(const MaterialApp(
                home: HomePagePlans(),
              ));
      },
    );
    //GETDATA LİST ÇEKME İŞLEMİ TAMAMLANDI
    //HER İHTİMALE KARŞI 500 MS BEKLENİYOR
  }
}
