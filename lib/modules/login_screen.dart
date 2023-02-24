import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_firebase/modules/chat_screen.dart';
import 'package:scholar_chat_firebase/modules/register_screen.dart';
import 'package:scholar_chat_firebase/shared/components/components.dart';
import 'package:scholar_chat_firebase/shared/components/widgets/scaffold_messenger.dart';

import '../shared/components/widgets/button.dart';
import '../shared/components/widgets/text_form_field.dart';
import '../shared/styles/colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword=true;

  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: mainColor,
        body: Container(
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
                      fontSize: 30, color: Colors.white, fontFamily: "Pacifico"),
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign In",
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
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormField(
                  validate: (value){
                    if(value ==null|| value.isEmpty)
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
                  submit: (value) {},
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(function: () async{
                  if(formKey.currentState!.validate()==true)
                    {
                      await signinMethod(context);

                    }
                }, text: "login"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("don't have an account ?",
                        style: TextStyle(color: Colors.white)),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          "Sign up",
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

  Future<void> signinMethod(BuildContext context) async {
     setState(() {
      isLoading=true;
    });
    try {
      await signWithEmailAndPassword();
      scaffoldMessengerText(context, "Success Login", Colors.green);
      navigateToAndReplace(context, ChatScreen(emailcontroller.text));

    }on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found') {
        scaffoldMessengerText(context, 'No user found for that email.', Colors.red);

      } else if (e.code == 'wrong-password') {
        scaffoldMessengerText(context, 'Wrong password provided for that user.', Colors.red);
      }
    } catch (e){
      scaffoldMessengerText(context, e.toString(), Colors.red);

    }
    setState(() {
      isLoading=false;
    });
  }

  Future<void> signWithEmailAndPassword() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth
        .signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text
    );
  }
}
