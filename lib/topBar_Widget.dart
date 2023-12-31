import 'package:flutter/material.dart';

import 'settingsPage/Page/settings_page.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key, required this.titleText});
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
            top: 6,
            right: 10,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              },
              child: const Icon(
                Icons.settings,
                size: 23,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
