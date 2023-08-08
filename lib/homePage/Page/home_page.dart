import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/Utils/firebase_manager.dart';
import 'package:moneymate/homePage/Widget/home_page_balance_row_widget.dart';
import 'package:moneymate/homePage/Widget/home_page_document_history_listview_widget.dart';
import 'package:moneymate/homePage/Widget/home_page_plans_photo_widget.dart';
import 'package:moneymate/topBar_Widget.dart';

class HomePagePlans extends StatefulWidget {
  const HomePagePlans({super.key, required this.docId});
  final String docId;

  @override
  State<HomePagePlans> createState() => _HomePagePlansState();
}

class _HomePagePlansState extends State<HomePagePlans> {
  @override
  void initState() {
    super.initState();
    incomeOrExpenseList.clear();
    fillData();
  }

  fillData() async {
    for (var element in paymentDataCache.keys) {
      print(element);
    }
    await FBManager.updatePaymentList();
    List l = await FBManager.receivePaymentDetails(widget.docId);
    for (var element in l) {
      incomeOrExpenseList.add(element);
    }

    valueNotifierX.value += 1;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifierX,
        builder: (context, value, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  TopBarWidget(
                      titleText: getdataList[startingIndex]["AccountName"]),
                  const SizedBox(height: 50),
                  const HomePagePlansPhotoWidget(),
                  const SizedBox(height: 20),
                  const HomePageBalanceRowWidget(),
                  const SizedBox(height: 40),
                  HomePageDocumentHistoruListview(),
                ],
              ),
            ),
          );
        });
  }
}
