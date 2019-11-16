import 'package:flutter/material.dart';

class Address extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return _AddressState();
    }
}

class _AddressState extends State<Address>{
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title:Text('Address'),
        ),
        
      );
    }
}