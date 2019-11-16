import 'package:flutter/material.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:store/user_screens/login.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  int line, line2 = 1;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController re_password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext context;
  AppMethods appMethods = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.green[500],
        appBar: AppBar(
          backgroundColor: Colors.green[500],
          title: Text('Sign Up'),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(height: 15.0),
            CircleAvatar(
              maxRadius: 70.0,
              backgroundColor: Colors.green[300],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 70.0,
                      color: Colors.white,
                    ),
                  ]),
            ),
            SizedBox(height: 40),
            appTextField2(
              isPassword: false,
              sidePadding: 12.0,
              textHint: 'Full Name',
              textIcon: Icons.person,
              controller: fullname,
            ),
            SizedBox(
              height: 10.0,
            ),
            appTextField2(
              isPassword: false,
              sidePadding: 12.0,
              textHint: 'Email',
              textIcon: Icons.email,
              controller: email,
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onDoubleTap: (){
                if(line2 ==0){
                  setState(() {
                   line2 = 1; 
                  });
                }else{
                  setState(() {
                   line2 = 0; 
                  });
                }
              },
              child: appTextField2(
                isPassword: line2 == 1?true:false,
                sidePadding: 12.0,
                textHint: 'Password',
                textIcon: Icons.lock,
                controller: password,
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onDoubleTap: () {
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
                isPassword: line == 1 ? true : false,
                sidePadding: 12.0,
                textHint: 'Confirm Password',
                textIcon: Icons.lock,
                controller: re_password,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            appTextField2(
              isPassword: false,
              sidePadding: 12.0,
              textHint: 'Phone Number',
              textIcon: Icons.phone,
              texttype: TextInputType.phone,
              controller: phoneNumber,
            ),
            appButton(
                buttonText: 'Create Account',
                buttonPadding: 15.0,
                buttoncolor: Colors.black,
                onBtnclick: verifyDetails),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              },
              child: Text('Already have an account? Log in here',
                  style: TextStyle(color: Colors.white)),
            )
          ],
        )));
  }

  verifyDetails() async {
    if (fullname.text == "") {
      showSnackBar(message: " Full name cannot be empty", key: scaffoldKey);
      return;
    }
    if (email.text == "") {
      showSnackBar(message: "Email cannot be empty", key: scaffoldKey);
      return;
    }
    if (password.text == "" || password.text.length < 6) {
      showSnackBar(
          message: "Password cannot be empty or passord is too short",
          key: scaffoldKey);
      return;
    }
    if (re_password.text == "") {
      showSnackBar(message: "Please re-enter your password", key: scaffoldKey);
      return;
    }
    if (password.text != re_password.text) {
      showSnackBar(message: "Passwords don't match", key: scaffoldKey);
      return;
    }
    if (phoneNumber.text == "") {
      showSnackBar(message: "Please enter your phone number", key: scaffoldKey);
      return;
    }
    displayProgressDialog(context);
    String response = await appMethods.createUser(
        fullname: fullname.text.toLowerCase(),
        email: email.text.toLowerCase(),
        password: password.text.toLowerCase(),
        phone: phoneNumber.text);

    if (response == successful) {
      closeProgressDialog(context);
      Navigator.of(context).pop(true);
      Navigator.of(context).pop(true);
    } else {
      closeProgressDialog(context);
      showSnackBar(message: response, key: scaffoldKey);
    }
  }
}
