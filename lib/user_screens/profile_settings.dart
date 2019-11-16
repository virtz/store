import 'package:flutter/material.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/user_screens/resetpassword.dart';

class ProfileSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileSettingsState();
  }
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String accountname;
  String accountEmail;
  String phone;
  String password;
  bool isLoggedIn;

  Future getCurrentUser() async {
    accountname = await getStringDataLocally(key: fullName);
    accountEmail = await getStringDataLocally(key: userEmail);
    phone = await getStringDataLocally(key: phoneNumber);
    isLoggedIn = await getBoolDataLocally(key: loggedIn);
    // print(await getStringDataLocally(key: userEmail));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Card(
              elevation: 4.0,
              child: Container(
                  height: 100.0,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 47.0,
                          child:
                              Icon(Icons.person, color: Colors.red, size: 40),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                accountname == null
                                    ? accountname = "guest user"
                                    : accountname,
                                style: TextStyle(fontSize: 19.0)),
                            SizedBox(height: 6.0),
                            Text(accountEmail == null
                                ? accountEmail = "youremail@gmail.com"
                                : accountEmail)
                          ],
                        ),
                      )
                    ],
                  ))),
          SizedBox(height: 48.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 8.0),
            child: Material(
              // elevation: 10.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Account Information",
                          style: (TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context) {
                            return ResetPassword();
                          })),
                            child: Text("Reset Password",
                                style: TextStyle(fontStyle: FontStyle.italic))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Divider(height: 10.0, color: Colors.black),
                  SizedBox(height: 8.0),
                  Container(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Text("Full Name",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(accountname == null
                                    ? accountname = "youraccountname"
                                    : accountname),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Text("Phone",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(phone == null
                                    ? phone = "yournumber"
                                    : phone),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Text("Email",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(accountEmail == null
                                    ? accountEmail = "youremail@gmail.com"
                                    : accountEmail),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Text("Status",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                    isLoggedIn == false
                                        ? "Not Active"
                                        : "Active",
                                    style: TextStyle(
                                        color: isLoggedIn == false
                                            ? Colors.black
                                            : Colors.green)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Row(
                        //   children: <Widget>[

                        //     SizedBox(width: 10.0),
                        //     Text("Password", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w600)),
                        //   ],
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     children: <Widget>[
                        //       Text("Obscured Text"),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 10, bottom: 10.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 27.0),
              Text("Your account information will appear here",
                  style: TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }
}
