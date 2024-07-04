import 'package:flutter/material.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';


import '../compenets/constants.dart';
import '../models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message}) : super(key: key);
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
       padding: const EdgeInsets.only(left: 8,top: 4,bottom: 12,right: 10),
        decoration:  BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(18),
            topLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
        ),
        child: Column(
          crossAxisAlignment:changeBubble? CrossAxisAlignment.start: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(message.name,
                style: const TextStyle(color: Colors.grey,
                    fontSize: 14,fontWeight: FontWeight.bold),),
            ),
            Text(message.message,style: const TextStyle(color: Colors.white,fontSize: 18),
            textAlign: TextAlign.end ,),
          ],
        ),
      ),
    );
  }
}



