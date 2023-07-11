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
    return Scaffold(
      body: PlansScreenForAppWidget(),
    );
  }
}
// Container(
//         child: Text(
//           getdataList[0]["name"],
//           style: TextStyle(
//               fontSize: 50, fontWeight: FontWeight.bold, color: Colors.red),
//         ),
//       ),
