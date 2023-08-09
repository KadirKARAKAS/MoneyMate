import 'package:moneymate/Utils/firebase_manager.dart';
import 'package:moneymate/models/savings_account_transaction.dart';

class SavingsAccount {
  num startingValue;
  String name;
  String photoURL;
  String targetValue;
  DateTime createdAt;
  String docId;
  List<SavingsAccountTransaction> transactions = [];
  SavingsAccount.fromMap(Map<String, dynamic> data)
      : startingValue = data["StartingValue"],
        name = data["AccountName"],
        photoURL = data["PetsPhotoURL"],
        targetValue = data["TargetValue"],
        createdAt = data["createdTime"].toDate(),
        docId = data["docId"];

  updateTransactions() async {
    print("Updating transactions");
    List<Map<String, dynamic>> l = await FBManager.receivePaymentDetails(docId);
    transactions.clear();
    for (var element in l) {
      transactions.add(SavingsAccountTransaction.fromMap(element));
    }
  }

  makeTransaction(Map<String, dynamic> transaction) async {
    await FBManager.addTransaction(transaction, docId);
  }

  // calculateBalance() {
  //   num balance = 0;
  //   for (var element in transactions) {
  //     if (element.isDeposit) {
  //       balance += element.amount;
  //     }
  //   }
}
