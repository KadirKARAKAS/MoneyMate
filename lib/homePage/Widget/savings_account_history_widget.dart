import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/models/savings_account.dart';
import 'package:moneymate/models/savings_account_transaction.dart';

class SavingsAccountHistoryWidget extends StatelessWidget {
  const SavingsAccountHistoryWidget({super.key, required this.savingsAccount});
  final SavingsAccount savingsAccount;

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
          height: 400,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: savingsAccount.transactions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return savingHistoryContainerWidget(context, index);
            },
          ),
        )
      ],
    );
  }

  Widget savingHistoryContainerWidget(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    SavingsAccountTransaction t = savingsAccount.transactions[index];
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
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.amount,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 3),
                    Text(t.isDeposit ? "Income" : "Expense",
                        style: t.isDeposit
                            ? const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)
                            : const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
