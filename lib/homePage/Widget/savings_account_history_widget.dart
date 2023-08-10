import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/models/savings_account.dart';
import 'package:moneymate/models/savings_account_transaction.dart';

class SavingsAccountHistoryWidget extends StatefulWidget {
  const SavingsAccountHistoryWidget({super.key, required this.savingsAccount});
  final SavingsAccount savingsAccount;

  @override
  State<SavingsAccountHistoryWidget> createState() =>
      _SavingsAccountHistoryWidgetState();
}

class _SavingsAccountHistoryWidgetState
    extends State<SavingsAccountHistoryWidget> with TickerProviderStateMixin {
  List<AnimationController> ac = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.savingsAccount.transactions.length + 1; i++) {
      AnimationController a = AnimationController(
          vsync: this, duration: Duration(milliseconds: 800 + 200 * i));
      ac.add(a);
      a.forward();
    }
  }

  @override
  void dispose() {
    for (var element in ac) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5, bottom: 3),
              child: Text("Savings account history",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            )),
        SizedBox(
          height: 420,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: widget.savingsAccount.transactions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                  animation: ac[min(index, ac.length - 1)],
                  builder: (context, child) {
                    return Opacity(
                        opacity: ac[min(index, ac.length - 1)].value,
                        child: savingHistoryContainerWidget(context, index));
                  });
            },
          ),
        )
      ],
    );
  }

  Widget savingHistoryContainerWidget(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    SavingsAccountTransaction t = widget.savingsAccount.transactions[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xfff5f5f5),
            ),
          ),
          Positioned(
            left: 3,
            top: 5,
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: CachedNetworkImage(
                      imageUrl: widget.savingsAccount.photoURL,
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
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.savingsAccount.name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 3),
                    Text(t.isDeposit ? "Income" : "Expense",
                        style: t.isDeposit
                            ? const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w400,
                                fontSize: 12)
                            : const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 12))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      t.amount.toString(),
                      style: t.isDeposit
                          ? const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 19)
                          : const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "\$",
                      style: t.isDeposit
                          ? const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 19)
                          : const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
