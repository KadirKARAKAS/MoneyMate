import 'package:moneymate/Utils/firebase_manager.dart';
import 'package:moneymate/models/savings_account_transaction.dart';

class SavingsAccount {
  int basicValue;
  String name;
  String photoURL;
  String targetValue;
  DateTime createdAt;
  String docId;
  List<SavingsAccountTransaction> transactions = [];
  SavingsAccount.fromMap(Map<String, dynamic> data)
      : basicValue = data["StartingValue"],
        name = data["AccountName"],
        photoURL = data["PetsPhotoURL"],
        targetValue = data["TargetValue"],
        createdAt = data["createdTime"].toDate(),
        docId = data["docId"];

  updateTransactions() async {
    List<Map<String, dynamic>> l = await FBManager.receivePaymentDetails(docId);
    transactions.clear();
    for (var element in l) {
      transactions.add(SavingsAccountTransaction.fromMap(element));
    }
  }
}
