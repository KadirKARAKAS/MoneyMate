import 'package:flutter/material.dart';

import '../../Utils/constants.dart';

class SettingsPageWidgets extends StatelessWidget {
  const SettingsPageWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topBorWidget(context),
        Container(),
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
}
