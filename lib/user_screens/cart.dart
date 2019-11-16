import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/firebase_methods.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartState();
  }
}

class _CartState extends State<Cart> {
  AppMethods appMethods = FirebaseMethods();
  List<bool> inputs = List<bool>();
  List cartItems = [];
  double price = 0;
  double quantity = 0;
  double total = 0;
  int n;
  bool isChecked = false;
  Firestore firestore = Firestore.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future _data;
  @override
  void initState() {
    super.initState();
    _data = appMethods.getUserCart(userID);
    setState(() {
      for (int i = 0; i < 10000; i++) {
        inputs.add(true);
        cartItems.add(i);
        getTotoalCount();
      }
    });
    //getTotoalCount();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var key;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: <Widget>[],
      ),
      extendBody: true,
      body: FutureBuilder(
          future: _data,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              //getTotoalCount();
              return noDataFound();
            }
            final int dataCount = snapshot.data.documents.length;
            if (dataCount == 0) {
              return noDataFound();
            }
            return ListView.builder(
              itemCount: dataCount,
              itemBuilder: (context, index) {
                // return buildCart(snapshot, index, context);
                n = dataCount;
                price =
                    double.parse(snapshot.data.documents[index][productPrice]);
                quantity =
                    double.parse(snapshot.data.documents[index][itemQuantity]);
                List productImage =
                    snapshot.data.documents[index][productImages] as List;
                final DocumentSnapshot document =
                    snapshot.data.documents[index];
                return Dismissible(
                  background: stackBehindDismiss(),
                  key: ObjectKey(document),
                  onDismissed: (direction) {
                    //firestore.collection(favorites).document().delete();
                    deleteCart(context, document, index);
                  },
                  child: GestureDetector(
                    onDoubleTap: (){
                      getTotoalCount();
                    },
                    child: Card(
                        elevation: isChecked ? 7.0 : 5.0,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(productImage[0]),
                                )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(document[productTitle],
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10.0),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          "N${double.parse(document[productPrice])}",
                                          style: TextStyle(fontSize: 16.5))),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 20.0,
                                      ),
                                      // SizedBox(height: 5.0),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 6.0),
                                        child: SizedBox(
                                          key: key,
                                          child: Text(
                                            "0.0",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),

                                      // SizedBox()
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                            "${int.parse(document[itemQuantity])}",
                                            style: TextStyle(fontSize: 18.0)),

                                        //             Checkbox(
                                        //   value:inputs[index] ,
                                        //   onChanged: (value) {
                                        //     setState(() {
                                        //       inputs[index] = value;
                                        //       getTotoalCount();
                                        //       // print(inputs[index]);
                                        //       // total = price * quantity;
                                        //       // cartItems[index] = value;
                                        //       // cartItems.add(document[productTitle]);
                                        //     });
                                        //   },
                                        // )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            );
          }),
      bottomNavigationBar: BottomAppBar(
        key: key,
        child: Material(
          elevation: 10.0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(15.0))),
            width: (screenSize).aspectRatio,
            height: 70.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.add_to_queue),
                        SizedBox(width: 5.0),
                        Text("Total :",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        SizedBox(width: 6.0),
                        Text(
                            total == null
                                ? total = 0.0
                                : total.toStringAsFixed(2),
                            style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                  SizedBox(width: 30.0),
                  Divider(height: 10.0, color: Colors.black),
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        //shape:BoxShape.circle,
                      ),
                      height: 50.0,
                      width: 150.0,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('ORDER',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0)),
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget noDataFound() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.find_in_page, color: Colors.black38, size: 80.0),
            Text("No Products available yet",
                style: TextStyle(color: Colors.black45, fontSize: 20.0)),
            Text("Please check your internet connection",
                style: TextStyle(color: Colors.red, fontSize: 15.0))
          ],
        ),
      ),
    );
  }

  deleteCart(BuildContext context, document, int index) async {
    appMethods.deleteFromCart(document.documentID).whenComplete(() {
      // setState(() {
      // store.removeAt(index) ;
      // });
    }).whenComplete(() {
      print("success");
    });
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red[600],
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  // Widget buildCart(snapshot, index, context) {}
  getTotoalCount() {
    for (int i = 0; i < 1000; i++) {
      total = price * quantity;
    }
  }
}
