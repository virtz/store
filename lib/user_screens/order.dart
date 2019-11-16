import 'package:flutter/material.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:intl/intl.dart';
import 'package:stripe_payment/stripe_payment.dart';

//import 'package:flutter_paystack/flutter_paystack.dart';

class Order extends StatefulWidget {
  final int itemQ;
  final String itemname;
  final String itemType;
  final String itemPrice;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Order({this.itemQ, this.itemname, this.itemType, this.itemPrice});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderState();
  }
}

class OrderState extends State<Order> {
  var publicKey = '[pk_test_46ec4c3efcf1100d1ed3e0272161fd63b1860b1a]';
  
  
  AppMethods appMethods = FirebaseMethods();
  final scaffoldKey = GlobalKey<ScaffoldState>();
   TextEditingController cardCont = TextEditingController();
  BuildContext context;
  String cardNumber;
  int expiryMonth;
  int expiryYear;
  String cvv = "408";
  // Card card = Card();

 @override
  void initState() {
    super.initState();
  // PaystackPlugin.initialize(
  //   publicKey: publicKey
  // );
  }
  
  //Charge charge = Charge();
  
  @override
  Widget build(BuildContext context) {
    this.context =  context;
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        title: Text('Order'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top:30.0),
            child: Card(
              //color: Colors.grey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                        Text("Product Title  :"),
                        SizedBox(height: 20.0,),
                        Text("${widget.itemname}"),
                      ],),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          Text("Product Type  :"),
                          SizedBox(height: 20.0,),
                          Text("${widget.itemType}"),
                        ],),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          Text("Product Price  :"),
                          SizedBox(height: 20.0,),
                          Text("${widget.itemPrice}"),
                        ],),
                    ),
                  ),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          Text("Quantity  :"),
                          SizedBox(height: 20.0,),
                          Text("${widget.itemQ}"),
                        ],),
                    ),
                  ),
                  SizedBox(height: 28.0,),
                  Center(child: Text("Card",style: TextStyle(fontSize:25.0,fontWeight: FontWeight.w700),)),
                  SizedBox(height:20.0),
                  appTextField(
                     isPassword: false,
                sidePadding: 12.0,
                textHint: 'Enter card number',
                textIcon: Icons.credit_card,
                controller: cardCont,
                  ),
                  SizedBox(height:15.0),
                      appButton(
                  buttonText: 'Order',
                  buttonPadding: 15.0,
                  buttoncolor: Colors.black,
                  onBtnclick: verifyOrder),
                ],
              
              ),
            ),
          ),
        ),
      )
    );
  }

  verifyOrder() async {
   
    var now = new DateTime.now();
    var formatter = new DateFormat.yMd().add_jm();
    String formatted = formatter.format(now);
    String response = await appMethods.userOrder(
      prodtTitle: widget.itemname,
      prodtPrice: widget.itemPrice,
      prodtVariation: widget.itemType,
      itemQty: widget.itemQ.toString(),
      date: formatted,
     
     
    );
    print(response);
      displayProgressDialog(context);
    if (response == successful) {
      closeProgressDialog(context);
      showInSnackBar(message: "Order was successful", key:scaffoldKey);

    } else {
      closeProgressDialog(context);
     showSnackBar(message: response, key: scaffoldKey);
    }
  }
}
