import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';

class HomePageBalanceRowWidget extends StatelessWidget {
  const HomePageBalanceRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage("assets/expenseplus.png"),
          width: 50,
          height: 50,
        ),
        const SizedBox(width: 30),
        Text(
          getdataList[startingIndex]["TargetValue"],
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 30),
        const Image(
          image: AssetImage("assets/incomeplus.png"),
          width: 50,
          height: 50,
        )
      ],
    );
  }
}
