import 'package:flutter/material.dart';
import 'package:moneymate/OnBoardPages/onBoardPlansScreen/Pages/firstOpeningPage.dart';

import '../../SavingsAccounts/Pages/savings_accounts.dart';

class SettingsPageWidgets extends StatelessWidget {
  const SettingsPageWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topBorWidget(context),
        settingsContainerWidget(context, "Birikim hesaplarım", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SavingsAccountsPage(),
              ));
        }),
        settingsContainerWidget(context, "Yeni birikim hesabı oluştur", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FirstOpeningPage(),
              ));
        }),
      ],
    );
  }

  Widget topBorWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        width: size.width,
        height: 80,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Center(
          child: Text(
            "Settings",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40, left: 10),
        child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_outlined,
                  size: 32,
                ))),
      ),
    ]);
  }

  Widget settingsContainerWidget(
      BuildContext context, String containerText, Function onTap) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: InkWell(
        onTap: () {
          onTap();
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Stack(children: [
          Container(
              width: size.width,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 0.5))),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    containerText,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
