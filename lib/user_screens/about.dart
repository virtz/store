import 'package:flutter/material.dart';

class About extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return _AboutState();
    }
}

class _AboutState extends State<About>{
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar:AppBar(
          title:Text('About Us'),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
               Card(
                 child: Column(
                   children: <Widget>[
                     Text('We at Axiom are a group of developers who ')
                   ],
                 ),
               ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Powered By '),
                    Text('AXIOM',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.w700),),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
}