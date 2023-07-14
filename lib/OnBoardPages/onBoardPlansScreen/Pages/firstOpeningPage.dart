import 'package:flutter/material.dart';
import 'package:moneymate/OnBoardPages/onBoardPlansScreen/Widgets/firstOpeningPage_widget.dart';

import '../../../Utils/constants.dart';

class FirstOpeningPage extends StatefulWidget {
  const FirstOpeningPage({super.key});

  @override
  State<FirstOpeningPage> createState() => _FirstOpeningPageState();
}

class _FirstOpeningPageState extends State<FirstOpeningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (firstpageBackbutton) topBorWidget(context),
          Center(child: FirstOpeningPageWidget(key: GlobalKey())),
        ],
      ),
    );
  }

  Widget topBorWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        width: size.width,
        height: 80,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Center(
          child: Text(
            "",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40, left: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_outlined,
              size: 32,
            ),
          ),
        ),
      ),
    ]);
  }
}
