import 'package:flutter/cupertino.dart';

List<Map<String, dynamic>> getdataList = [];
List<Map<String, dynamic>> incomedataList = [];
final TextEditingController incomeTextController = TextEditingController();
final TextEditingController expenseTextController = TextEditingController();
int balance = 0;
String incomeBalanceValue = incomeTextController.text;
String expenseBalanceValue = expenseTextController.text;
String plansName = "";
