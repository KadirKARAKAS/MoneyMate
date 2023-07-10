import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final usersCol = FirebaseFirestore.instance.collection("Plans");

  List<Map<String, dynamic>> getdataList = [];
}
