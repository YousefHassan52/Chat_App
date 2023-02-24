import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class CustomFormField extends StatelessWidget {
  TextEditingController? controller;

  String? text;
  Icon? prefixIcon;
  TextInputType keyboardType;
  IconData? suffix;
  bool isPassword;
  Function? suffixPressed;
  Color textColor;
  Function(String)? submit;
  Function(String)? change;
  FormFieldValidator<String>? validate;

  Color mainFieldColor;

  CustomFormField({
    this.suffix,
    this.controller,
    this.text,
    this.prefixIcon,
    required this.keyboardType,
    this.isPassword=false,
    this.suffixPressed,
    this.textColor=Colors.white,
    this.submit,
    this.validate,
    this.change,

    this.mainFieldColor=Colors.white,




});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,

       onChanged: change??(value){},

      style: TextStyle(

          color: mainFieldColor
      ),
      onFieldSubmitted: submit,

      controller: controller ,
      keyboardType: keyboardType ,
      decoration: InputDecoration(


        hintText: text,
        hintStyle: TextStyle(


            color: mainFieldColor
        ),
        prefixIcon: prefixIcon,

        suffixIcon:suffix!=null?IconButton(
          icon: Icon(suffix,color: mainFieldColor,),
          onPressed: (){suffixPressed!();},):null, // lw passet 7aga lel suffix el suffixicon hayb2a beysawi el suffix el baseto else yeb2a mafeee4(null)
        border:OutlineInputBorder(
          borderSide: BorderSide(color: mainFieldColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainFieldColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: mainFieldColor,
          ),


        ),
        filled: false,

      ),
      obscureText:isPassword,



    );
  }
}

