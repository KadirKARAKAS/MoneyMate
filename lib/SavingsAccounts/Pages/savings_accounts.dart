import 'package:flutter/material.dart';
import '../Widget/savings_account_widget.dart';

class SavingsAccountsPage extends StatefulWidget {
  const SavingsAccountsPage({super.key});

  @override
  State<SavingsAccountsPage> createState() => _SavingsAccountsPageState();
}

class _SavingsAccountsPageState extends State<SavingsAccountsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SavingsAccountPageWidget(),
    );
  }
}
