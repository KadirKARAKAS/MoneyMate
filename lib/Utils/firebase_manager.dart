import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FBManager {
  static Future<List<Map<String, dynamic>>> receivePaymentDetails(
      String docId) async {
    List<Map<String, dynamic>> l = [];
    String userId = FirebaseAuth.instance.currentUser!.uid;

    final planRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("My Plans");
    QuerySnapshot<Map<String, dynamic>> planDetails =
        await planRef.doc(docId).collection("Income&Expense").get();

    planDetails.docs.forEach((element) {
      l.add(element.data());
    });
    return l;
  }
}
