import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/homePage/Widget/home_page_balance_row_widget.dart';
import 'package:moneymate/homePage/Widget/home_page_document_history_listview_widget.dart';
import 'package:moneymate/homePage/Widget/home_page_plans_photo_widget.dart';
import 'package:moneymate/topBar_Widget.dart';

class HomePagePlans extends StatefulWidget {
  const HomePagePlans({super.key});
  @override
  State<HomePagePlans> createState() => _HomePagePlansState();
}

class _HomePagePlansState extends State<HomePagePlans> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBarWidget(titleText: getdataList[startingIndex]["AccountName"]),
            const SizedBox(height: 50),
            const HomePagePlansPhotoWidget(),
            const SizedBox(height: 20),
            const HomePageBalanceRowWidget(),
            const SizedBox(height: 40),
            const HomePageDocumentHistoruListview(),
            InkWell(
              onTap: () async {
                final userReff = FirebaseFirestore.instance
                    .collection("Users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("My Plans")
                    .doc(getdataList[startingIndex]["docId"])
                    .collection("Income&Expense")
                    .orderBy('createdTime', descending: true);

                final querySnapshott = await userReff.get();
                querySnapshott.docs.forEach((doc) {
                  incomeOrExpenseList.add(doc.data() as Map<String, dynamic>);
                });
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
