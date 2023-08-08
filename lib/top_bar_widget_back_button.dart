import 'package:flutter/material.dart';

class TopBarWidgetBackButton extends StatelessWidget {
  const TopBarWidgetBackButton({super.key, required this.titleText});
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Stack(
        children: [
          Center(
            child: Text(
              titleText,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 1.5)]),
            ),
          ),
          Positioned(
            top: 3,
            left: 10,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.navigate_before,
                size: 33,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
