import 'package:flutter/material.dart';
import 'package:store/tools/appData.dart';
import 'package:store/user_screens/categories.dart';
import 'user_screens/myhomepage.dart';
import  'user_screens/login.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scoped_models/products.dart';

void main() => runApp(MyApp());
   class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return  MaterialApp(
      title: 'Demo',
      theme: ThemeData(


        primaryColor: Colors.blue,
        //accentColor: Colors.red
      ),
      debugShowCheckedModeBanner: false,
      home: Categories(),
      routes:{
        '/login':(BuildContext context)=> LoginPage(),
      } ,
    );
  }
}

