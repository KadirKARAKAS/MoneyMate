import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';

import '../Widget/plansScreenForAppWidget.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  @override
  Widget build(BuildContext context) {
    print(getdataList[2]['price']);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PlansScreenForAppWidget(),
          ],
        ),
      ),
    );
  }
}
