import 'package:chat_app_new/common/components/default_button.dart';
import 'package:chat_app_new/common/components/form_error.dart';
import 'package:chat_app_new/common/constants.dart';
import 'package:chat_app_new/common/keyboard.dart';
import 'package:chat_app_new/views/new_ui/sign_in_up_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:core';

import 'decoration_functions.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  late double height, width;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFF6A62B7),
                      // color: Color.fromRGBO(225, 95, 27, .3),
                      blurRadius: 20,
                      offset: Offset(0, 5))
                ]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    decoration: signInInputDecoration(hintText: 'Email'),
                  ),

                  // child: EmailTextFormField(
                  //   decoration: signInInputDecoration(hintText: 'Email'),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    decoration: signInInputDecoration(hintText: 'Password'),
                  ),

                  // child: PasswordTextFormField(
                  //   decoration: signInInputDecoration(hintText: 'Password'),
                  // ),
                ),

                //buildEmailFormField(),
                // SizedBox(height: height * 0.040),
                // //buildPasswordFormField(),
                // SizedBox(height: height * 0.040),

                // DefaultButton(
                //     text: "Continue",
                //     press: () {
                //       if (_formKey.currentState!.validate()) {
                //         _formKey.currentState!.save();
                //         // if all are valid then go to success screen
                //         KeyboardUtil.hideKeyboard(context);
                //         // Navigator.push(
                //         //     context,
                //         //     MaterialPageRoute(
                //         //         builder: (context) => LoginSuccessScreen()));
                //       }
                //     }),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(6, 0, 15, 9),
            // color: Colors.amber,
            // child: Row(
            //   children: [
            //     Checkbox(
            //       value: remember,
            //       activeColor: kPrimaryColor,
            //       onChanged: (val) {
            //         setState(() {
            //           remember = val!;
            //         });
            //       },
            //     ),
            //     // Text("Remember me"),
            //     // Spacer(),
            //     // GestureDetector(
            //     //   onTap: () {},
            //     //   child: Text(
            //     //     "Forgot Password",
            //     //     style: TextStyle(decoration: TextDecoration.underline),
            //     //   ),
            //     // )
            //   ],
            // ),
          ),
          FormError(errors: errors),
          SizedBox(height: height * 0.040),
          SignInBar(
            label: 'Sign in',
            isLoading: false, onPressed: () {},
            //isSubmitting,
            // onPressed: () {
            //   context.signInWithEmailAndPassword();
            // },
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            width * 0.036,
            width * 0.036,
            width * 0.036,
          ),
          child: SvgPicture.asset(
            "assets/icons/Mail.svg",
            height: width * 0.050,
          ),
        ),
        //CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            width * 0.036,
            width * 0.036,
            width * 0.036,
          ),
          child: SvgPicture.asset(
            "assets/icons/Lock.svg",
            height: width * 0.050,
          ),
        ),
        //CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
