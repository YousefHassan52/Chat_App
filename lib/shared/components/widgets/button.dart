import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class CustomButton extends StatelessWidget {
  String text;
  VoidCallback function;
   Color background ;
   double width ;
   double height ;
   bool isUpperCase ;

  double radius ;


  CustomButton({
    this.width= double.infinity,
    this.height=50,
    this.background=Colors.white,
    this.isUpperCase=true,
    this.radius=10,
    required this.function,
    required this.text});

  @override
  Widget build(BuildContext context) {
    return  Container(

      width: double.infinity,
      height:height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: IconButton(
        onPressed:function,
        icon: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color:  mainColor,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}

