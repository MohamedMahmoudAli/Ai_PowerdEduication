import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton(
      {super.key,
      required this.buttonText,
      required this.color,
      required this.textColor});
  final String buttonText;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: textColor),
      ),
    );
  }
}
