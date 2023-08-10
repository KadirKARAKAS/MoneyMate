import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneymate/Utils/constants.dart';
import 'package:moneymate/models/savings_account.dart';

class FBManager {
  static Future<List<Map<String, dynamic>>> receivePaymentDetails(
      String docId) async {
    List<Map<String, dynamic>> l = [];
    String userId = FirebaseAuth.instance.currentUser!.uid;

    final planRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("My Plans");
    QuerySnapshot<Map<String, dynamic>> planDetails = await planRef
        .doc(docId)
        .collection("Income&Expense")
        .orderBy("createdTime", descending: true)
        .get();

    planDetails.docs.forEach((element) {
      l.add(element.data());
    });
    return l;
  }

  static updatePaymentList() async {
    List l = await FBManager.receivePaymentDetails(
        getdataList[startingIndex]["docId"]);
    incomeOrExpenseList.clear();
    for (var element in l) {
      incomeOrExpenseList.add(element);
    }
  }

  static updatePlanList() async {
    final userRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Plans")
        .orderBy('createdTime', descending: true);

    final querySnapshot = await userRef.get();
    getdataList.clear();
    savingsAccounts.clear();
    querySnapshot.docs.forEach((doc) async {
      getdataList.add(doc.data());
      savingsAccounts.add(SavingsAccount.fromMap(doc.data()));
    });
  }

  static addTransaction(
      Map<String, dynamic> transaction, String savingsAccountId) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Plans")
        .doc(savingsAccountId)
        .collection("Income&Expense")
        .add(transaction);
  }
}
