import 'package:flutter/material.dart';

class SettingsContainerWidget extends StatelessWidget {
  const SettingsContainerWidget(
      {super.key, required this.containerText, required this.onTap});
  final String containerText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: size.width,
        height: 65,
        decoration: BoxDecoration(
            border: Border.all(width: 0.4),
            borderRadius: BorderRadius.circular(18),
            color: const Color(0xfff5f5f5),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 2, color: Colors.black26, offset: Offset(0, 1))
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                containerText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )),
        ),
      ),
    );
  }
}
