import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:store/user_screens/cart.dart';
import 'package:store/user_screens/order.dart';

class ItemDetails extends StatefulWidget {
final  String itemName;
 final  String itemImage;
final   String itemSubname;
final   String itemDescription;
 final  String itemPrice;
 final  List itemImages;
 final  String itemQuantity;
 final  int iquantity;
 final  String itemType;
 final  double itemRating;
  // bool isfavorited;

  ItemDetails(
      {this.itemName,
      this.itemImage,
      this.itemSubname,
      this.itemDescription,
      this.itemPrice,
      this.itemImages,
      this.itemQuantity,
      this.iquantity,
      this.itemType,
      this.itemRating});

  @override
  State<StatefulWidget> createState() {
    return _ItemDetailsState();
  }
}

class _ItemDetailsState extends State<ItemDetails> {
  int flag = 0;
  String favorite = "true";
  var response2;
  final Set<dynamic> _saved = Set<dynamic>();
  String accountName = "";
  int iquantity = 0;
 var carttCount;
  AppMethods appMethods = FirebaseMethods();
  final scaffoldKey = GlobalKey<ScaffoldState>();
   bool alreadySaved ;

  int length; 
  Future getCurrentUser() async {
    accountName = await getStringDataLocally(key: fullName);
    // accountEmail = await getStringDataLocally(key: userEmail);
    // acctPhotoUrl = await getStringDataLocally(key: photoUrl);
    // isLoggedIn = await getBoolDataLocally(key: loggedIn);
    // print(await getStringDataLocally(key: userEmail));
    accountName == null ? accountName = "Guest User" : accountName;
    // accountEmail == null ? accountEmail = "guestuser@gmail.com" : accountEmail;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
     appMethods.getCartCount().then((result){
    setState(() {
     carttCount = result;
    });
 });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
  alreadySaved = _saved.contains(widget.itemName);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Details'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            height: 300.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.itemImage),
                    fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(120.0),
                  bottomLeft: Radius.circular(120.0),
                )),
          ),
          Container(
            height: 300.0,
            decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(120.0),
                  bottomLeft: Radius.circular(120.0),
                )),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(0.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Card(
                child: Container(
                  width: screenSize.width,
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(widget.itemName,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.itemSubname,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(Icons.star,
                                    color: Colors.blue, size: 20.0),
                                Text("0.0"),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Row(children: <Widget>[
                            
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "N${widget.itemPrice}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              )
                            ]),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        )
                      ]),
                ),
              ),
              Card(
                  child: Container(
                width: screenSize.width,
                height: 150.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.itemImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5.0, right: 5.0),
                          height: 140.0,
                          width: 100.0,
                          child: Image.network(widget.itemImages[index]),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0, right: 5.0),
                          height: 140.0,
                          width: 100.0,
                          decoration:
                              BoxDecoration(color: Colors.grey.withAlpha(50)),
                        ),
                      ],
                    );
                  },
                ),
              )),
              Card(
                  child: Container(
                      width: screenSize.width,
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Description',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(widget.itemDescription,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ))),
              Card(
                child: Container(
                  width: screenSize.width,
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('Quantity',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  )),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(widget.itemQuantity),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('Variations',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  )),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(widget.itemType),
                              SizedBox(height: 10.0),
                            ],
                          ),
                        ],

                        /*SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.itemQuantity.length,
                    itemBuilder: (context, index){
                      return 
                        Padding(
                          padding: const EdgeInsets.all(4.0),

                          child:ChoiceChip(
                            label: Text("Quantity ${index}"),
                            selected: false,
                          ),);
                    },
                  ),
                ),*/
                      ),

                      /* SizedBox(
                  height: 50.0, 
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index){
                      return
                        Padding(
                          padding: const EdgeInsets.all(4.0),

                          child:ChoiceChip(
                            label: Text("Variations ${index}"),
                            selected: false,
                          ),
                      
                      );
                    },
                  ),
                ),*/
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Quantity',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new CircleAvatar(
                            child: IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => _decrementCounter(),
                            ),
                          ),
                          Text(
                            '$iquantity',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          CircleAvatar(
                            child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => _incrementCounter(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      )
                    ],
                  ),
                ),
              )
            ]),
          )
        ],
      ),
      floatingActionButton: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
               //cartCount(context);
              //  print(carttCount);
               if(accountName != "Guest User"){
                addToCart();
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return Cart();
              }));
               }
                showInSnackBar(message:"Please sign in",key:scaffoldKey);
            },
            child: Icon(Icons.shopping_cart),
          ),
          CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: Text(carttCount == null?carttCount = "0":
              "$carttCount",
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0.0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Container(
          height: 70.0,
          decoration: BoxDecoration(
              // color: Theme.of(context).primaryColor
              ),
          child: GestureDetector(
            onTap: () {
             addToFavorites();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: (screenSize.width - 20) / 2,
                  child: Text(
                    'ADD TO FAVORITES',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: (screenSize.width - 20) / 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Order(
                                itemQ: iquantity,
                                itemname: widget.itemName,
                                itemType: widget.itemType,
                                itemPrice: widget.itemPrice,
                              )));
                    },
                    child: Text(
                      'ORDER NOW',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // List<File> images;
  //   String productID  = await appMethods.userCart();
  //   List<String> imageUrl = await appMethods.uploadProductImages(
  //       docID: productID, imageList:itemImages);
  void _incrementCounter() {
    setState(() {
      iquantity++;
    });
  }

  void _decrementCounter() {
    setState(() {
      iquantity--;
    });
  }

  addToFavorites() async {
    String response = await appMethods.getFavorites(
      prodtTitle: widget.itemName,
      prodtVariation: widget.itemType,
      prodtPrice: widget.itemPrice,
      itemQty: widget.itemQuantity.toString(),
      prodtImages: widget.itemImages,
      isFavorited: favorite,
    );
    if (response == successful) {
      print(_saved);
  return _ackAlert(context, "Item has been added to favorites", "Added to favorites");
    } else if (accountName == "Guest User") {
     return _ackAlert(context, "Please sign-in to add item to cart", "Log In");
    } else {}
  }

  addToCart() async {
  
      String response = await appMethods.userCart(
      prodtTitle: widget.itemName,
      prodtVariation: widget.itemType,
      prodtPrice: widget.itemPrice,
      itemQty: iquantity.toString(),
      prodtImages: widget.itemImages,
    );
    print(iquantity);
    if (response == successful) {
      return _ackAlert(context, "Item has been added to cart", "Added To Cart");
    } else {
      showSnackBar(message: "Sorry and error occured", key: scaffoldKey);
    }
   
  
  }
 
  
    
    Future _ackAlert(BuildContext context,String message,String header) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(header),
        content:  Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

}
