import 'package:flutter/material.dart';

void navigateToAndReplace(context,Widget widget)
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=> widget), (route) => false);
}