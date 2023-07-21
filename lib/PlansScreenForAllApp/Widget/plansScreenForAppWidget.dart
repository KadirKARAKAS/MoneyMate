import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/SettingsPage/Pages/settings_page_main.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlansScreenForAppWidget extends StatefulWidget {
  const PlansScreenForAppWidget({Key? key}) : super(key: key);

  @override
  State<PlansScreenForAppWidget> createState() =>
      _PlansScreenForAppWidgetState();
}

class _PlansScreenForAppWidgetState extends State<PlansScreenForAppWidget> {
  bool isShowIncomeAlertDialog = false;
  bool isexpenseShowIncomeAlertDialog = false;

  late TextEditingController incomeTextController;
  late TextEditingController expenseTextController;

  @override
  void initState() {
    super.initState();
    incomeTextController = TextEditingController();
    expenseTextController = TextEditingController();
  }

  @override
  void dispose() {
    incomeTextController.dispose();
    expenseTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              topBorWidget(),
              plansimagecircle(context, 170, 170),
              plansbalancevalue(context),
              finaloperations(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 3),
                  shrinkWrap: true,
                  itemCount: incomedataList.length,
                  itemBuilder: (context, index) {
                    final bool boolValue = incomedataList[index]["BoolValue"];
                    return boolValue
                        ? incomefinalOperationsContainer(index)
                        : expensefinalOperationsContainer(index);
                  },
                ),
              ),
            ],
          ),
          isShowIncomeAlertDialog ? incomeAlertDialog() : const SizedBox(),
          isexpenseShowIncomeAlertDialog
              ? expenseAlertDialog()
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget plansimagecircle(BuildContext context, double widthh, double heighht) {
    return ClipOval(
      child: Container(
        width: widthh,
        height: heighht,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
        ),
        child: CachedNetworkImage(
          imageUrl: imageURLL,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.attach_money),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget plansbalancevalue(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    isexpenseShowIncomeAlertDialog = true;
                  });
                },
                child: Icon(
                  Icons.remove_circle_outlined,
                  color: Colors.red,
                  size: 60,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Text(
                  balance.toString(),
                  style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(
                  "₺",
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    isShowIncomeAlertDialog = true;
                  });
                },
                child: Icon(
                  Icons.add_circle_outlined,
                  color: Colors.green,
                  size: 60,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                balance.toString(),
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 2),
            Container(
              child: Text(
                "/",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 2),
            Container(
              child: Text(
                getdataList[selectedIndex]["price"],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget finaloperations() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 30),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Container(
                child: const Text(
                  "Son işlemler",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Icon(
            Icons.navigate_next,
            color: Colors.grey,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget incomefinalOperationsContainer(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              plansimagecircle(context, 80, 80),
              const SizedBox(
                width: 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getdataList[selectedIndex]["name"],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    "Gelir Eklendi",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                incomedataList[index]["Income"],
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "₺",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget incomeAlertDialog() {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isShowIncomeAlertDialog = false;
            });
          },
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.black45,
          ),
        ),
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text("Gelir Ekle"),
          actions: [
            TextField(
              controller: incomeTextController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Birikim hesabınıza para ekleyin',
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: InkWell(
                  onTap: () async {
                    addtoHistoryFunction();
                    await FirebaseFirestore.instance
                        .collection("Plans")
                        .doc(plansName)
                        .collection('Income&Expense')
                        .get()
                        .then((value) {
                      incomedataList.clear();
                      for (var docSnapshot in value.docs) {
                        Map<String, dynamic> xMap = docSnapshot.data();
                        incomedataList.addAll([xMap]);
                      }
                    });

                    setState(() {
                      balance += int.parse(incomeTextController.text);
                      isShowIncomeAlertDialog = false;
                    });

                    incomeBalanceValue = incomeTextController.text;
                    incomeTextController.clear();
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "Ekle",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(16),
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> addtoHistoryFunction() async {
    String text1 = incomeTextController.text;
    plansName;

    final newIncome = {
      "Income": text1,
      "BoolValue": true,
    };

    await FirebaseFirestore.instance
        .collection("Plans")
        .doc(plansName)
        .collection("Income&Expense")
        .add(newIncome);

    setState(() {
      balance += int.parse(incomeTextController.text);
      isShowIncomeAlertDialog = false;
      incomedataList.add(newIncome);
    });

    incomeBalanceValue = incomeTextController.text;
    incomeTextController.clear();
  }

  Future<void> addtoExpenseHistoryFunction() async {
    String text1 = expenseTextController.text;
    plansName;

    final newExpense = {
      "Expense": text1,
      "BoolValue": false,
    };

    await FirebaseFirestore.instance
        .collection("Plans")
        .doc(plansName)
        .collection("Income&Expense")
        .add(newExpense);

    setState(() {
      balance -= int.parse(expenseTextController.text);
      isexpenseShowIncomeAlertDialog = false;
      incomedataList.add(newExpense);
    });

    expenseBalanceValue = expenseTextController.text;
    expenseTextController.clear();
  }

  Widget expenseAlertDialog() {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isexpenseShowIncomeAlertDialog = false;
            });
          },
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.black45,
          ),
        ),
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text("Gider Ekle"),
          actions: [
            TextField(
              controller: expenseTextController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Birikim hesabınıdan para çekin',
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: InkWell(
                  onTap: () async {
                    addtoExpenseHistoryFunction();
                    await FirebaseFirestore.instance
                        .collection("Plans")
                        .doc(plansName)
                        .collection("Income&Expense")
                        .get()
                        .then((value) {
                      incomedataList.clear();
                      for (var docSnapshot in value.docs) {
                        Map<String, dynamic> xMap = docSnapshot.data();
                        incomedataList.addAll([xMap]);
                      }
                    });

                    setState(() {
                      balance -= int.parse(expenseTextController.text);
                      isexpenseShowIncomeAlertDialog = false;
                    });

                    expenseBalanceValue = expenseTextController.text;
                    expenseTextController.clear();
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "Ekle",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(16),
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget expensefinalOperationsContainer(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              plansimagecircle(context, 80, 80),
              SizedBox(
                width: 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getdataList[selectedIndex]["name"],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Gider Eklendi",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                incomedataList[index]["Expense"],
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "₺",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget topBorWidget() {
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
            getdataList[selectedIndex]["name"],
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40, right: 15),
        child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
            child: Icon(Icons.settings),
          ),
        ),
      ),
    ]);
  }
}
