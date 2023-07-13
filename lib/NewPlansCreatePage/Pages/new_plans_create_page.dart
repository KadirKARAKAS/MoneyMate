import 'package:flutter/material.dart';
import 'package:moneymate/NewPlansCreatePage/Widget/new_plans_create_page_widget.dart';

class NewPlansCreatePage extends StatefulWidget {
  const NewPlansCreatePage({super.key});

  @override
  State<NewPlansCreatePage> createState() => _NewPlansCreatePageState();
}

class _NewPlansCreatePageState extends State<NewPlansCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NewPlansCreatePageWidget(),
    );
  }
}
