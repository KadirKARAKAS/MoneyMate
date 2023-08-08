import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/homePage/Page/home_page.dart';
import 'package:moneymate/savingsAccounts/Widget/savings_account_container_widget.dart';
import 'package:moneymate/top_bar_widget_back_button.dart';

class SavingsAccountPage extends StatefulWidget {
  const SavingsAccountPage({super.key});

  @override
  State<SavingsAccountPage> createState() => _SavingsAccountPageState();
}

class _SavingsAccountPageState extends State<SavingsAccountPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifierX,
        builder: (context, value, child) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
              children: [
                const TopBarWidgetBackButton(titleText: "Savings Accounts"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: getdataList.length,
                        itemBuilder: (context, index) {
                          return SavingsAccountContainerWidget(
                            containerText: getdataList[index]["AccountName"],
                            onTap: () async {
                              final userReff = FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("My Plans")
                                  .doc(getdataList[selectedIndex]["docId"])
                                  .collection("Income&Expense");

                              final querySnapshott = await userReff.get();

                              incomeOrExpenseList.clear();
                              await Future.forEach(querySnapshott.docs,
                                  (planDoc) async {
                                final incomeExpenseRef = planDoc.reference
                                    .collection("Income&Expense")
                                    .orderBy('createdTime', descending: true);

                                final incomeExpenseSnapshot =
                                    await incomeExpenseRef.get();

                                incomeExpenseSnapshot.docs.forEach((doc) {
                                  incomeOrExpenseList.add(doc.data());
                                });
                              });
                              valueNotifierX.value += 1;
                              startingIndex = index;
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePagePlans(),
                                  ));
                            },
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
        });
  }
}
