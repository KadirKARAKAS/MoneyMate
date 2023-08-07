import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          print(getdataList);
        },
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
            Text(getdataList[0]["TargetValue"])
          ],
        ),
      ),
    );
  }
}
