import 'package:flutter/material.dart';
import 'package:moneymate/addPlanPage/Page/add_plan_page.dart';
import 'package:moneymate/savingsAccounts/Page/savings_account_page.dart';
import 'package:moneymate/settingsPage/Widget/settings_container_widget.dart';
import 'package:moneymate/top_bar_widget_back_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const TopBarWidgetBackButton(titleText: "Settings"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              SettingsContainerWidget(
                  containerText: "Create a new savings account",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddPlanPage(),
                        ));
                  }),
              const SizedBox(height: 15),
              SettingsContainerWidget(
                  containerText: "Savings accounts",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SavingsAccountPage(),
                        ));
                  })
            ],
          ),
        )
      ],
    ));
  }
}
