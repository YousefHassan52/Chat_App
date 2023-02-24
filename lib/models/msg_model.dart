import 'package:scholar_chat_firebase/shared/components/constants.dart';

class MsgModel{
  final String msg;
  final String email;

  MsgModel(this.msg, this.email);
  factory MsgModel.fromJson(json)
  {
    return MsgModel(json[txtOfMsg],json["email"]);
  }
}