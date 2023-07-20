import 'package:flutter/cupertino.dart';

//List
List<Map<String, dynamic>> getdataList = [];
List<Map<String, dynamic>> incomedataList = [];
//controller
final TextEditingController incomeTextController = TextEditingController();
final TextEditingController expenseTextController = TextEditingController();

//String
String savingsPlansName = "";
String incomeBalanceValue = incomeTextController.text;
String expenseBalanceValue = expenseTextController.text;
String plansName = "";
String imageURLL = "";

//int
int balance = 0;

//bool
bool firstpageBackbutton = false;
bool isVisible = false;

int selectedIndex = 0;
