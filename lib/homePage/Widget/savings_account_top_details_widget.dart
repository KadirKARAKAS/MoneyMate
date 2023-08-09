import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/expense&incomePage/Page/make_transaction_page.dart';
import 'package:moneymate/models/savings_account.dart';

class SavingsAccountTopDetails extends StatelessWidget {
  const SavingsAccountTopDetails({super.key, required this.savingsAccount});
  final SavingsAccount savingsAccount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        SavingsAccountPhotoWidget(
          savingsAccount: savingsAccount,
        ),
        const SizedBox(height: 20),
        SavingsAccountPageBalanceRowWidget(savingsAccount: savingsAccount),
        const SizedBox(height: 40),
      ],
    );
  }
}

class SavingsAccountPageBalanceRowWidget extends StatelessWidget {
  const SavingsAccountPageBalanceRowWidget(
      {super.key, required this.savingsAccount});
  final SavingsAccount savingsAccount;

  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => MakeTransactionPage(
                    savingsAccount: savingsAccount,
                  ),
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
          balanceDetails(),
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 30),
        InkWell(
          onTap: () {
            expenseOrIncome = "Income";
            expenseOrIncomeBool = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MakeTransactionPage(
                    savingsAccount: savingsAccount,
                  ),
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
  }

  String balanceDetails() {
    return savingsAccount.balance.toString() +
        " / " +
        savingsAccount.targetValue.toString();
  }
}

class SavingsAccountPhotoWidget extends StatelessWidget {
  const SavingsAccountPhotoWidget({super.key, required this.savingsAccount});
  final SavingsAccount savingsAccount;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifierX,
        builder: (context, value, child) {
          return Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: CachedNetworkImage(
                imageUrl: savingsAccount.photoURL,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 50,
                ),
              ),
            ),
          );
        });
  }
}
