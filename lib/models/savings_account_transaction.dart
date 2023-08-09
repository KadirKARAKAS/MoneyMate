class SavingsAccountTransaction {
  bool isDeposit;
  DateTime createdAt;
  num amount;
  SavingsAccountTransaction.fromMap(Map<String, dynamic> data)
      : isDeposit = data["ValueType"],
        createdAt = data["createdTime"].toDate(),
        amount = data["Value"];
}
