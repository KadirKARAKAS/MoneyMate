import 'package:flutter/material.dart';
import 'package:moneymate/OnBoardPages/onBoardPlansScreen/Widgets/firstOpeningPage_widget.dart';

class FirstOpeningPage extends StatefulWidget {
  const FirstOpeningPage({super.key});

  @override
  State<FirstOpeningPage> createState() => _FirstOpeningPageState();
}

class _FirstOpeningPageState extends State<FirstOpeningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstOpeningPageWidget(),
    );
  }
}
