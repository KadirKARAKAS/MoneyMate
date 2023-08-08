import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/Utils/firebase_manager.dart';
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
                  TextInputType.number,
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: addToDatabase,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: expenseOrIncomeBool ? Colors.green : Colors.red,
                      ),
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container savingAccountdetailcontainer(
    Size size,
    String containerText,
    TextEditingController controllerr,
    TextInputType keyboard,
  ) {
    return Container(
      width: size.width,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 0.3, color: const Color(0xff979797)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            color: Colors.black26,
            offset: Offset(-2, 2),
          ),
        ],
      ),
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
                color: Color(0xff979797),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addToDatabase() async {
    String value = expenseOrIncomeController.text;

    final savingAccount = {
      "Value": value,
      "ValueType": expenseOrIncomeBool,
      'createdTime': DateTime.now(),
    };

    // Yeni veriyi Firebase'e ekleyin ve belge referansını alın
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Plans")
        .doc(getdataList[startingIndex]["docId"])
        .collection("Income&Expense")
        .add(savingAccount);
    if (paymentDataCache.containsKey(getdataList[startingIndex]["docId"])) {
      paymentDataCache.remove(getdataList[startingIndex]["docId"]);
    }
    await FBManager.updatePaymentList();
    // await FBManager.receivePaymentDetails(getdataList[startingIndex]["docId"]);
    // Firebase'den veriyi çekerek listenizi güncelleyin
    // await fetchIncomeAndExpenseData();
    setState(() {
      Future.delayed(const Duration(milliseconds: 400), () {});
      circleBool = false;
      expenseOrIncomeController.clear();
      Navigator.pop(context);
      valueNotifierX.value += 1;
    });
  }

  Future<void> fetchIncomeAndExpenseData() async {
    final userRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Plans");

    final querySnapshot = await userRef.get();

    incomeOrExpenseList.clear();
    await Future.forEach(querySnapshot.docs, (planDoc) async {
      final incomeExpenseRef = planDoc.reference
          .collection("Income&Expense")
          .orderBy('createdTime', descending: true);

      final incomeExpenseSnapshot = await incomeExpenseRef.get();

      incomeExpenseSnapshot.docs.forEach((doc) {
        incomeOrExpenseList.add(doc.data());
      });
    });

    setState(() {
      Future.delayed(const Duration(milliseconds: 400), () {
        valueNotifierX.value += 1;
      });
      circleBool = false;
      expenseOrIncomeController.clear();
      Navigator.pop(context);
    });
  }
}
