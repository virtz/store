import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store/tools/appData.dart';

import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';


class ResetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPassword> {
  int line = 1;
  int line2 = 1;
  int line3 = 1;
  TextEditingController em = TextEditingController();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confimrPassword = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AppMethods appMethods = FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0.0,
          title: Text("Password Reset", style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height / 20,
              ),
              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  child: Icon(
                    Icons.lock_open,
                    size: 50.0,
                  ),
                ),
              ),
              SizedBox(
                height: height / 50 + 10,
              ),
              Material(
                //elevation: 5.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: appTextField2(
                          textHint: "Email",
                          textIcon: Icons.person,
                          isPassword: false,
                          controller: em),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: GestureDetector(
                        onDoubleTap: (){
                           if (line == 0) {
                            setState(() {
                              line = 1;
                            });
                          } else {
                            setState(() {
                              line = 0;
                            });
                          }
                        },
                        child: appTextField2(
                          textHint: "Current Password",
                          textIcon: Icons.lock,
                          isPassword: line == 1 ? true : false,
                          controller: oldpassword,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: GestureDetector(
                        onDoubleTap: () {
                          if (line2 == 0) {
                            setState(() {
                              line2 = 1;
                            });
                          } else {
                            setState(() {
                              line2 = 0;
                            });
                          }
                        },
                        child: appTextField2(
                            textHint: "New Password",
                            isPassword: line2 == 1 ? true : false,
                            textIcon: Icons.lock_open,
                            controller: newpassword),
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: GestureDetector(
                        onDoubleTap: () {
                          if (line3 == 0) {
                            setState(() {
                              line3 = 1;
                            });
                          } else {
                            setState(() {
                              line3 = 0;
                            });
                          }
                        },
                        child: appTextField2(
                            textHint: "Confirm Password",
                            isPassword: line3 == 1 ? true : false,
                            textIcon: Icons.lock_outline,
                            controller: confimrPassword),
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: appButton(
                        buttonText: "Reset Password",
                        buttoncolor: Colors.white,
                        btnColor: Colors.blue,
                        onBtnclick: () {
                          passWordReset();
                        },
                      ),
                    ),
                    SizedBox(
                      height: height / 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  passWordReset() async {
    bool response;
    if (em.text == "" ||
        newpassword.text == "" ||
        confimrPassword.text == "" ||
        oldpassword.text == "") {
      showSnackBar(message: " Fields cannot be empty", key: scaffoldKey);
      return;
    } else if (newpassword.text != confimrPassword.text) {
      showSnackBar(message: "Passwords don't match", key: scaffoldKey);
      return;
    } 
      displayProgressDialog(context);
      // CloudFunctions.instance.call(
      //   functionName: "changePassword",
      //   parameters: {
      //   "currentPassword":oldpassword.text,
      //   "newPassword":newpassword.text,
      //   }
      //);
      try{
         response = await appMethods.changePassword(
        eMail: em.text,
        currentpassword: oldpassword.text,
          passWord: confimrPassword.text,
      ).catchError((e)=>{
        print(e),
      }).then((reponse){
        reponse = true;
      });
      }on PlatformException catch(e){
        print(e);
      }
      if (response == true) {
        closeProgressDialog(context);
        showInSnackBar(message: "Password reset successful", key: scaffoldKey);
      } else {
        closeProgressDialog(context);
        showSnackBar(message: response.toString(),key: scaffoldKey);
      }
    }
  
}
