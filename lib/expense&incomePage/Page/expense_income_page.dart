import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/topBar_Widget.dart';

class ExpenseIncomePage extends StatefulWidget {
  const ExpenseIncomePage({super.key});

  @override
  State<ExpenseIncomePage> createState() => _ExpenseIncomePageState();
}

final TextEditingController expenseOrIncomeController = TextEditingController();

class _ExpenseIncomePageState extends State<ExpenseIncomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          TopBarWidget(titleText: expenseOrIncome),
          const SizedBox(height: 200),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  savingAccountdetailcontainer(
                      size,
                      "Enter the amount $expenseOrIncome",
                      expenseOrIncomeController,
                      TextInputType.number),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        addToDatabase();
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              expenseOrIncomeBool ? Colors.green : Colors.red,
                        ),
                        child: const Center(
                            child: Text(
                          "Add",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Container savingAccountdetailcontainer(Size size, String containerText,
      TextEditingController controllerr, TextInputType keyboard) {
    return Container(
      width: size.width,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(width: 0.3, color: const Color(0xff979797)),
          boxShadow: const [
            BoxShadow(
                blurRadius: 1, color: Colors.black26, offset: Offset(-2, 2))
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextField(
              keyboardType: keyboard,
              controller: controllerr,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: containerText,
                  hintStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff979797)))),
        ),
      ),
    );
  }

  Future<void> addToDatabase() async {
    String value = expenseOrIncomeController.text;

    final savingAccount = {
      expenseOrIncome: value,
      'createdTime': DateTime.now()
    };

    final docRef = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Plans")
        .doc(getdataList[startingIndex]["docId"])
        .collection("Income&Expense")
        .add(savingAccount);

    // Oluşturulan belgeye docID ekleme aşaması
    await docRef.update({'docId': docRef.id});
    expenseOrIncomeController.clear();

    final userRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Plans")
        .doc(getdataList[startingIndex]["docId"])
        .collection("Income&Expense")
        .orderBy('createdTime', descending: true);

    final querySnapshot = await userRef.get();
    incomeOrExpense.clear();
    querySnapshot.docs.forEach((doc) async {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("My Plans")
          .doc(getdataList[startingIndex]["docId"])
          .collection("Income&Expense");

      incomeOrExpense.add(doc.data());
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      incomeOrExpense.isEmpty
          ? AlertDialog(
              actions: [],
            )
          : setState(() {
              circleBool = false;
              Navigator.pop(context);
            });
    });
  }
}
