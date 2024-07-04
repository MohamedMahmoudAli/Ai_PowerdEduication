import 'package:flutter/material.dart';

import '../compenets/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox(
      {super.key,
      required this.result,
      required this.questionLength,
      required this.onPressed,required this.cheating});
  final cheating;
  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
                backgroundColor: result == questionLength / 2
                    ? Colors.yellow //when the result is half of the questions
                    : result < questionLength / 2
                        ? incorrect
                        : correct,
                radius: 50,
                child: Text(
                  '$result/$questionLength',
                  style: const TextStyle(fontSize: 22, color: neutral1),
                )),
            const SizedBox(height: 20),
            Text(cheating),
            Text(
              result == questionLength / 2
                  ? "Almost there" //when the result is half of the questions
                  : result < questionLength / 2
                      ? "Try again"
                      : "Great!",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: onPressed,
              child:  Text(
                "Start Over",
                style: TextStyle(
                    color: kPrimaryColor, fontSize: 20, letterSpacing: 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
