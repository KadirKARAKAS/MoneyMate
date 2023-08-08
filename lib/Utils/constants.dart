import 'package:flutter/cupertino.dart';

//List
List<Map<String, dynamic>> getdataList = [];
List<Map<String, dynamic>> incomedataList = [];
List<Map<String, dynamic>> incomeOrExpenseList = [];

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
bool circleBool = false;
int selectedIndex = 0;
int startingIndex = 0;
String topBarTitle = "";
String startingTargetValue = "";
String expenseOrIncome = "";
String valueQuantity = "";
bool expenseOrIncomeBool = false;
ValueNotifier<int> valueNotifierX = ValueNotifier(0);
