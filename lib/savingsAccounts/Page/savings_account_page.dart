import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
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
                      onTap: () {
                        valueNotifierX.value += 1;
                        startingIndex = index;
                        Navigator.pop(context);
                        Navigator.pop(context);
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
  }
}
