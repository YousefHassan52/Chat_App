import 'package:flutter/material.dart';
import 'package:scholar_chat_firebase/models/msg_model.dart';

import '../../styles/colors.dart';

class FriendChatbubble extends StatelessWidget {
  final MsgModel model;

  FriendChatbubble(this.model);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 30),

        decoration: BoxDecoration(
            color: Color(0xffBADED7),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              topLeft: Radius.circular(50),
            )
        ),
        child: Text(model.msg,style: TextStyle(color: Colors.white,fontSize: 16),),
      ),
    );
  }
}
