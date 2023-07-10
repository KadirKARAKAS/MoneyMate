import 'package:flutter/material.dart';

import '../Widget/plansScreenForAppWidget.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  @override
  Widget build(BuildContext context) {
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
