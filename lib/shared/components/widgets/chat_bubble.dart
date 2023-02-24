import 'package:flutter/material.dart';
import 'package:scholar_chat_firebase/models/msg_model.dart';

import '../../styles/colors.dart';

class ChatBubble extends StatelessWidget {
  final MsgModel model;

  ChatBubble(this.model);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 30),

        decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            )
        ),
        child: Text(model.msg,style: TextStyle(color: Colors.white,fontSize: 16),),
      ),
    );
  }
}
