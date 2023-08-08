import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/expense&incomePage/Page/expense_income_page.dart';

class HomePageBalanceRowWidget extends StatelessWidget {
  const HomePageBalanceRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifierX,
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  expenseOrIncome = "Expense";
                  expenseOrIncomeBool = false;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExpenseIncomePage(),
                      ));
                },
                child: const Image(
                  image: AssetImage("assets/expenseplus.png"),
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(width: 30),
              Text(
                getdataList[startingIndex]["TargetValue"],
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 30),
              InkWell(
                onTap: () {
                  expenseOrIncome = "Income";
                  expenseOrIncomeBool = true;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExpenseIncomePage(),
                      ));
                },
                child: const Image(
                  image: AssetImage("assets/incomeplus.png"),
                  width: 50,
                  height: 50,
                ),
              )
            ],
          );
        });
  }
}
