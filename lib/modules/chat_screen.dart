import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat_firebase/shared/components/constants.dart';
import 'package:scholar_chat_firebase/shared/components/widgets/friend_chat_bubble.dart';
import 'package:scholar_chat_firebase/shared/components/widgets/text_form_field.dart';
import 'package:scholar_chat_firebase/shared/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/msg_model.dart';
import '../shared/components/widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  final String email;

  ChatScreen(this.email);

  var msgController = TextEditingController();
  var scrollController = ScrollController();
  CollectionReference msgs =
      FirebaseFirestore.instance.collection(msgCollection);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapShot) {
        //snapshot heya 7aga feha el data beta3ti

        if (snapShot.hasData) {
          List<MsgModel> msgList = [];

          //print(snapShot.data!.docs[0]["textOfMsg"]);
          for (int i = 0; i < snapShot.data!.docs.length; i++) {
            msgList.add(MsgModel.fromJson(snapShot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 50,
                    fit: BoxFit.contain,
                    image: AssetImage("assets/images/scholar.png"),
                  ),
                  Text("Chat"),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  if (msgList.length != 0)
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          if (msgList[index].email == email)
                            return ChatBubble(msgList[index]);
                          else
                            return FriendChatbubble(msgList[index]);
                        },
                        itemCount: msgList.length,
                      ),
                    )
                  else
                    Expanded(child: Center(child: Text("empty"))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomFormField(
                      controller: msgController,
                      submit: (value) async {
                        if (value != null) {
                          msgs.add({
                            txtOfMsg: msgController.text,
                            createdAt: DateTime.now(),
                            "email": email,
                          });
                          msgController.clear();
                          scrollController.animateTo(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }
                      },
                      keyboardType: TextInputType.text,
                      mainFieldColor: mainColor,
                      suffix: Icons.send_outlined,
                      suffixPressed: () {
                        if (msgController.text != null) {
                          msgs.add({
                            txtOfMsg: msgController.text,
                            createdAt: DateTime.now(),
                            "email": email,
                          });
                          msgController.clear();
                          scrollController.animateTo(
                              0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
      stream: msgs.orderBy(createdAt, descending: true).snapshots(),
    );
  }
}
