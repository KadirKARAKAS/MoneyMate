import 'package:flutter/material.dart';

class TopBarWidgetBasic extends StatelessWidget {
  const TopBarWidgetBasic({super.key, required this.titleText});
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Center(
        child: Text(
          titleText,
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black, blurRadius: 1.5)]),
        ),
      ),
    );
  }
}
