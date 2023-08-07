import 'package:flutter/material.dart';
import 'package:moneymate/addPlanPage/Widget/plan_detail_textfield_widget.dart';
import 'package:moneymate/topBar_Widget.dart';

class AddPlanPage extends StatefulWidget {
  const AddPlanPage({super.key});

  @override
  State<AddPlanPage> createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TopBarWidget(titleText: "Add Saving Account"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 50),
              PlanDetailTextFieldWidget(),
            ],
          ),
        )
      ],
    ));
  }
}
