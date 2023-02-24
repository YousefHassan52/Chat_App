import 'package:flutter/material.dart';

void scaffoldMessengerText(
    BuildContext context, String warningText, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(

      content: Text(
        warningText,
        style: TextStyle(
          color: color,
        ),
      )));
}