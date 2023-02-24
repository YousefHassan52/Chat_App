import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../shared/components/components.dart';
import '../shared/components/widgets/button.dart';
import '../shared/components/widgets/scaffold_messenger.dart';
import '../shared/components/widgets/text_form_field.dart';
import '../shared/styles/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var isLoading = false;

  bool isPassword=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        color: Colors.black,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 3,
                ),
                Image.asset("assets/images/scholar.png"),
                Text(
                  "Scholar Chat",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: "Pacifico"),
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomFormField(
                  validate: (value) {
                    if (value == null || value.isEmpty)
                      return "Email is required";
                  },
                  controller: emailcontroller,
                  text: "Email Address",
                  keyboardType: TextInputType.emailAddress,
                  submit: (value) {
                    emailcontroller.text = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormField(
                  validate: (value) {
                    if (value == null || value.isEmpty)
                      return "Password is required";
                  },
                  controller: passwordcontroller,
                  text: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: isPassword,
                  suffix:isPassword==true? Icons.remove_red_eye:Icons.block,
                  suffixPressed: () {
                    setState(() {
                      isPassword=!isPassword;

                    });
                  },
                  submit: (value) {
                    passwordcontroller.text = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                    function: () async {
                      if (formKey.currentState!.validate() == true) {
                        await registerMethod(context);
                      }
                    },
                    text: "Register"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ?",
                        style: TextStyle(color: Colors.white)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Color(0xffC7E8E7)),
                        ))
                  ],
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerMethod(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    bool error=true;
    try {
      await registerWithEmailAndPassword();
      // lw fe 8alat fe el line el fo2 el ta7teh m4 hayetnafez 34an kda 7tat msg el success 25er 7aga
      scaffoldMessengerText(context, "Success Registeration", Colors.green);
      navigateToAndReplace(context, ChatScreen(emailcontroller.text));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        error = true;
        scaffoldMessengerText(
            context,
            "The account already exists for that email",
            Colors.red);
      } else if (e.code == 'weak-password') {
        error = true;
        scaffoldMessengerText(
            context,
            "The password provided is too weak",
            Colors.red);
      }
    } catch (e) {
      error = true;
      print(e);
    }

    setState(() {
      isLoading = false;
    });
    if (error == false )
      scaffoldMessengerText(
          context, "Success Registeration", Colors.green);
  }



  Future<void> registerWithEmailAndPassword() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: emailcontroller.text,
      password: passwordcontroller.text,
    );
  }
}
