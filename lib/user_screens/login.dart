import 'package:flutter/material.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:store/user_screens/myhomepage.dart';
import 'package:store/user_screens/resetpassword.dart';
import 'package:store/user_screens/siign_up.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext context;
  AppMethods appMethods = FirebaseMethods();
  int line = 1;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Login'),
          elevation: 0.0,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap:(){
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SignUp()));
                },
                child: Text("Sign-up")),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            CircleAvatar(
              maxRadius: 100.0,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.lock_open,
                    size: 120.0,
                    color: Colors.black,),
                     
                  ]),
            ),
            SizedBox(height: 70.0),
            appTextField2(
              isPassword: false,
              sidePadding: 12.0,
              textHint: 'Email',
              textIcon: Icons.email,
              controller: email,
            ),
            SizedBox(height: 12.0),
            GestureDetector(
              onDoubleTap: (){
                if(line == 0){
                  setState(() {
                   line = 1; 
                  });
                }else{
                  setState(() {
                   line = 0; 
                  });
                }
              },
                          child: appTextField2(
                isPassword: line == 1?true:false,
                sidePadding: 12.0,
                textHint: 'Password',
                textIcon: Icons.lock,
                controller: password,
              ),
            ),
         //SizedBox(height:2.0),
          SizedBox(height:2.0),
            appButton(
                buttonText: 'Login',
              buttonPadding: 10.0 ,
                buttoncolor: Colors.black,
                btnColor: Colors.white,
                onBtnclick: verifyLogin),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ResetPassword()));
              },
              child: Text('Forgot password ?',
                  style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic)),
            )
          ],
        )));
  }

  verifyLogin() async {
    if (email.text == "") {
      showSnackBar(message: "Email cannot be empty", key: scaffoldKey);
      return;
    } else if (password.text == "") {
      showSnackBar(message: "Password cannot be empty", key: scaffoldKey);
      return;
    }
    displayProgressDialog(context);
    String response = await appMethods.loginUser(
        email: email.text.toLowerCase(), password: password.text.toLowerCase());
    if (response == successful) {
      closeProgressDialog(context);
         Navigator.of(context).pop(true);
    } else {
      closeProgressDialog(context);
      showSnackBar(message: response.toString(), key: scaffoldKey);
    }
  }

showDialogue(){
  
}
}
