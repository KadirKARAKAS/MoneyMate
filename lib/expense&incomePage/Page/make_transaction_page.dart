import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/models/savings_account.dart';
import 'package:moneymate/topBar_Widget.dart';
import 'package:moneymate/top_bar_widget_back_button.dart';

class MakeTransactionPage extends StatefulWidget {
  const MakeTransactionPage({super.key, required this.savingsAccount});
  final SavingsAccount savingsAccount;

  @override
  State<MakeTransactionPage> createState() => _MakeTransactionPageState();
}

final TextEditingController expenseOrIncomeController = TextEditingController();

class _MakeTransactionPageState extends State<MakeTransactionPage> {
  late SavingsAccount savingsAccount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    savingsAccount = widget.savingsAccount;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              TopBarWidgetBackButton(titleText: expenseOrIncome),
              const SizedBox(height: 100),
              SizedBox(
                width: 150,
                height: 150,
                child:
                    SavingsAccountPhotoWidget(savingsAccount: savingsAccount),
              ),
              const SizedBox(height: 40),
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
                        onTap: () async {
                          setState(() {
                            circleBool = true;
                          });
                          await addToDatabase();
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
          loadingCircle(size),
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

    final transaction = {
      "Value": int.parse(value),
      "ValueType": expenseOrIncomeBool,
      'createdTime': DateTime.now(),
    };
    await widget.savingsAccount.makeTransaction(transaction);
    await widget.savingsAccount.updateTransactions();

    Future.delayed(const Duration(milliseconds: 400), () {});
    circleBool = false;
    expenseOrIncomeController.clear();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    valueNotifierX.value += 1;
    setState(() {
      circleBool = false;
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
  }

  Stack loadingCircle(Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (circleBool)
          Container(
            width: size.width,
            height: size.height - 200,
            color: Colors.transparent,
          ),
        circleBool
            ? const SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff60F9FF)),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class SavingsAccountPhotoWidget extends StatelessWidget {
  const SavingsAccountPhotoWidget({super.key, required this.savingsAccount});
  final SavingsAccount savingsAccount;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: savingsAccount.docId,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: CachedNetworkImage(
            imageUrl: savingsAccount.photoURL,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
