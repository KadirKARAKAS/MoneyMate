import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/homePage/Widget/home_page_balance_row_widget.dart';
import 'package:moneymate/homePage/Widget/home_page_plans_photo_widget.dart';
import 'package:moneymate/topBar_Widget.dart';

class HomePagePlans extends StatefulWidget {
  const HomePagePlans({super.key});
  @override
  State<HomePagePlans> createState() => _HomePagePlansState();
}

class _HomePagePlansState extends State<HomePagePlans> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarWidget(titleText: getdataList[startingIndex]["AccountName"]),
          const Column(
            children: [
              SizedBox(height: 50),
              HomePagePlansPhotoWidget(),
              SizedBox(height: 20),
              HomePageBalanceRowWidget(),
            ],
          )
        ],
      ),
    );
  }
}
