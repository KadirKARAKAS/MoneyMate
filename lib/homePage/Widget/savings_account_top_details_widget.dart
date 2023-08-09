import 'dart:math';

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

class SavingsAccountPageBalanceRowWidget extends StatefulWidget {
  const SavingsAccountPageBalanceRowWidget(
      {super.key, required this.savingsAccount});
  final SavingsAccount savingsAccount;

  @override
  State<SavingsAccountPageBalanceRowWidget> createState() =>
      _SavingsAccountPageBalanceRowWidgetState();
}

class _SavingsAccountPageBalanceRowWidgetState
    extends State<SavingsAccountPageBalanceRowWidget>
    with TickerProviderStateMixin {
  late AnimationController ac;

  @override
  void initState() {
    // TODO: implement initState
    ac = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    ac.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

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
                    savingsAccount: widget.savingsAccount,
                  ),
                ));
          },
          child: const Image(
            image: AssetImage("assets/expenseplus.png"),
            width: 40,
            height: 40,
          ),
        ),
        const SizedBox(width: 20),
        AnimatedBuilder(
            animation: ac,
            builder: (context, child) {
              return Container(
                width: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 30,
                              width: 200 *
                                  min(
                                      widget.savingsAccount.balance /
                                          widget.savingsAccount.targetValue,
                                      1),
                              decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(10 * (ac.value)),
                                      bottomRight:
                                          Radius.circular(10 * (ac.value)),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                            ),
                            Container(
                              height: 30,
                              // ignore: unnecessary_cast
                              width: 200 *
                                  min(
                                      widget.savingsAccount.balance /
                                          widget.savingsAccount.targetValue,
                                      1) *
                                  ac.value as double,
                              decoration:
                                  coloredBalanceContainerDecoration(true),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 200 *
                              (1 -
                                  min(
                                      widget.savingsAccount.balance /
                                          widget.savingsAccount.targetValue,
                                      1)),
                          decoration: coloredBalanceContainerDecoration(false),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        balanceDetails(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(
                                (255 * ac.value).toInt(), 0, 0, 0)),
                      ),
                    )
                  ],
                ),
              );
            }),
        const SizedBox(width: 20),
        InkWell(
          onTap: () {
            expenseOrIncome = "Income";
            expenseOrIncomeBool = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MakeTransactionPage(
                    savingsAccount: widget.savingsAccount,
                  ),
                ));
          },
          child: const Image(
            image: AssetImage("assets/incomeplus.png"),
            width: 40,
            height: 40,
          ),
        )
      ],
    );
  }

  BoxDecoration coloredBalanceContainerDecoration(bool isLeftSide) {
    double r = 10;
    double topLeft = 0, topRight = 0, bottomLeft = 0, bottomRight = 0;
    Color c = Colors.red.shade100;
    num difference =
        widget.savingsAccount.targetValue - widget.savingsAccount.balance;
    if (isLeftSide) {
      c = Colors.green.shade100;
      topLeft = r;
      bottomLeft = r;
      if (difference <= 0) {
        topRight = r;
        bottomRight = r;
      }
    } else {
      topRight = r;
      bottomRight = r;
      if (widget.savingsAccount.balance == 0) {
        topLeft = r;
        bottomLeft = r;
      }
    }

    return BoxDecoration(
        color: c,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRight),
            bottomRight: Radius.circular(bottomRight),
            topLeft: Radius.circular(topLeft),
            bottomLeft: Radius.circular(bottomLeft)));
  }

  String balanceDetails() {
    return widget.savingsAccount.balance.toString() +
        " / " +
        widget.savingsAccount.targetValue.toString();
  }
}

class SavingsAccountPhotoWidget extends StatelessWidget {
  const SavingsAccountPhotoWidget({super.key, required this.savingsAccount});
  final SavingsAccount savingsAccount;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: savingsAccount.docId,
      child: Container(
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
      ),
    );
  }
}
