import 'package:flutter/material.dart';

import '../compenets/constants.dart';
import '../models/message.dart';

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(left: 8,top: 4,bottom: 12,right: 10),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
          ),
          color: Color(0xff4A4E69),
        ),
        child: Column(
          crossAxisAlignment:changeBubble? CrossAxisAlignment.end: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom:4),
              child: Text(message.name,
                style: const TextStyle(color: Colors.grey,
                    fontSize: 14,fontWeight: FontWeight.bold),),
            ),


            Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}