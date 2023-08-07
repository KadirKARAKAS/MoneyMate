import 'package:flutter/material.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key, required this.titleText});
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
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
