import 'package:flutter/material.dart';
import 'package:mabruk_2026/utils/styles/normal_text.dart';

class MainMenuButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool leftButton;
  final Function onNavigate;
  const MainMenuButton({
    super.key,
    required this.text,
    required this.onNavigate,
    this.icon = Icons.home,
    this.leftButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: ElevatedButton(
        onPressed: () {
          onNavigate();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          elevation: 5.0,
          shadowColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            NormalText(text, size: 14, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
