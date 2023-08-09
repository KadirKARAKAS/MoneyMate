import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';

import 'package:moneymate/homePage/Widget/savings_account_history_widget.dart';
import 'package:moneymate/homePage/Widget/savings_account_top_details_widget.dart';
import 'package:moneymate/models/savings_account.dart';
import 'package:moneymate/topBar_Widget.dart';

class SavingsAccountDetailsPage extends StatefulWidget {
  SavingsAccountDetailsPage({super.key, required this.savingsAccount});
  final SavingsAccount savingsAccount;

  @override
  State<SavingsAccountDetailsPage> createState() =>
      _SavingsAccountDetailsPageState();
}

class _SavingsAccountDetailsPageState extends State<SavingsAccountDetailsPage> {
  // late SavingsAccount savingsAccount;
  bool isReady = false;
  @override
  void initState() {
    super.initState();

    fillData();
  }

  fillData() async {
    await widget.savingsAccount.updateTransactions();
    isReady = true;
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
                  TopBarWidget(titleText: widget.savingsAccount.name),
                  SavingsAccountTopDetails(
                      savingsAccount: widget.savingsAccount),
                  !isReady
                      ? SizedBox.shrink()
                      : SavingsAccountHistoryWidget(
                          savingsAccount: widget.savingsAccount,
                        ),
                ],
              ),
            ),
          );
        });
  }
}
