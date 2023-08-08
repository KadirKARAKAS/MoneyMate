import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneymate/Utils/constants.dart';

class FBManager {
  static Future<List<Map<String, dynamic>>> receivePaymentDetails(
      String docId) async {
    print("11: " + docId);
    if (paymentDataCache.containsKey(docId)) {
      print("cached");
      return paymentDataCache[docId]!;
    }
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
    paymentDataCache[docId] = l;
    return paymentDataCache[docId]!;
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
    querySnapshot.docs.forEach((doc) async {
      getdataList.add(doc.data());
    });
  }
}
