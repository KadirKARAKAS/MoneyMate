import 'package:flutter/material.dart';
import 'package:moneymate/PlansScreenForAllApp/Widget/plansScreenForAppWidget.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          width: size.width,
          height: size.height,
          color: Color(0xfff2f2f2),
        ),
        const PlansScreenForAppWidget()
      ]),
    );
  }
}
