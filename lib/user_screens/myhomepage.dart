import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:store/adminScreens/adminHome.dart';
import 'package:store/tools/appData.dart';


import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:store/user_screens/categories.dart';
import 'package:store/user_screens/favorites.dart';
import 'package:store/user_screens/login.dart';  

import 'package:store/user_screens/cart.dart';

import 'package:store/user_screens/order_history.dart';
import 'package:store/user_screens/profile_settings.dart';

import 'package:store/user_screens/address.dart';
import 'package:store/user_screens/about.dart';

import 'package:store/user_screens/item_details.dart';

import 'package:store/user_screens/search.dart';
//import 'package:store/tools/appData.dart';

class MyHomePage extends StatefulWidget {
 final  String prodctCategory;
  MyHomePage({this.prodctCategory});
  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State<MyHomePage> {
 
  BuildContext context;
  String accountName = "";
  String accountEmail = "";
  String acctPhotoUrl = "";
  bool isLoggedIn;
  AppMethods appMethods = FirebaseMethods();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Firestore firestore = Firestore.instance;
  var store = [];
  DocumentSnapshot document;
  bool alreadySaved;
  final Set<dynamic> _saved = Set<dynamic>();
  int flag;
  //static int get number => null;
  Size screenSize;
  var counter;
  int count;
  var data;
  // Store store = Store.items();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
 
  
 
   appMethods.getCartCount().then((result){
    setState(() {
     counter = result;
    });
 });
  }

  Future getCurrentUser() async {
    accountName = await getStringDataLocally(key: fullName);
    accountEmail = await getStringDataLocally(key: userEmail);
    acctPhotoUrl = await getStringDataLocally(key: photoUrl);
    isLoggedIn = await getBoolDataLocally(key: loggedIn);
    print(await getStringDataLocally(key: userEmail));
    accountName == null ? accountName = "Guest User" : accountName;
    accountEmail == null ? accountEmail = "guestuser@gmail.com" : accountEmail;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    this.context = context;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: GestureDetector(
            onLongPressUp: openAdmin,
            child: Text('ShopEx',
                style: TextStyle(
                    fontFamily: "Montserrat", fontStyle: FontStyle.italic))),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
              if(accountName == "Guest User"){
                showInSnackBar(message: "Please sign in",key:scaffoldKey);
               
                
              }else{
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Favorites();
                }));
              }
        
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              tooltip: 'open favorites page',
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.search, color: Colors.white),
          //   onPressed: () {
          //     if (pagevisible == 0) {
          //       setState(() {
          //         pagevisible = 1;
          //       });
          //     } else if (pagevisible == 1) {
          //       setState(() {
          //         pagevisible = 0;
          //       });
          //     }
          //   },
          // )
          /*Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    return Messages();
                  }));
                },
                icon: Icon(Icons.chat, color: Colors.white),
              ),
              CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.red,
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              )
            ],
          )*/
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: firestore
                .collection(appProducts)
                .where("productCategory", isEqualTo:widget.prodctCategory)
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  )),
                );
              } else {
                getCount();
                final int dataCount = snapshot.data.documents.length;
                // store.add(snapshot.data.documents);
                print("data count $dataCount");
                //print(widget.prodctCategory);
                if (dataCount == 0) {
                  return noDataFound();
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemCount: dataCount,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot document =
                          snapshot.data.documents[index];

                      return buildProducts(context, index, document);
                    },
                  );
                }
              }
            }),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              // setState((){
              //   pagevisible = true;
              // });
              if (accountName == "Guest User") {
                showInSnackBar(message: "Please sign in", key: scaffoldKey);
              } else {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Cart();
                }));
              }
            },
            child: Icon(Icons.shopping_cart),
          ),
          CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: Text(counter == null?counter = "0":
              "$counter",
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(accountName),
              accountEmail: Text(accountEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20.0),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Categories();
                }));
              },
              leading: CircleAvatar(
                child: Icon(
                  Icons.category,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text(' Categories'),
            ),

            ListTile(
              onTap: () {
              if(accountName == "Guest User"){
                showInSnackBar(message:"Please sign in",key:scaffoldKey);
              }
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return OrderHistory();
                }));
              },
              leading: CircleAvatar(
                child: Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Order History'),
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.of(context)
            //         .push(CupertinoPageRoute(builder: (BuildContext context) {
            //       return Categories();
            //     }));
            //   },
            //   leading: CircleAvatar(
            //     child: Icon(Icons.category),
            //   ),
            //   title: Text('Categories'),
            // ),
            // SizedBox(height: 20.0),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return ProfileSettings();
                }));
              },
              leading: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Profile Information'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Address();
                }));
              },
              leading: CircleAvatar(
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Home Address'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Search();
                }));
              },
              leading: CircleAvatar(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Search'),
            ),
            SizedBox(
              height: 15.0,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return About();
                }));
              },
              leading: Text('About Us'),
              trailing: CircleAvatar(
                child: Icon(Icons.help),
              ),
            ),
            ListTile(
              onTap: () {
                checkIfLoggedIn();
              },
              leading: Text(isLoggedIn == true ? "Logout" : "Login"),
              trailing: CircleAvatar(child: Icon(Icons.person)),
            ),
          ],
        ),
      ),
    );
  }

  checkIfLoggedIn() async {
    if (isLoggedIn == false) {
      bool response = await Navigator.of(context)
          .push(CupertinoPageRoute<bool>(builder: (BuildContext context) {
        return LoginPage();
      }));
      if (response == true) getCurrentUser();

      return;
    }
    _alertDialogue(context, "Do you really want to logout", "Log Out");
    
  }

  void openAdmin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return AdminHome();
    }));
  }

  // void _pushSaved() {}
  Widget noDataFound() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.find_in_page, color: Colors.black38, size: 80.0),
            Text("No Products available yet",
                style: TextStyle(color: Colors.black45, fontSize: 20.0)),
            Text("Please check back later",
                style: TextStyle(color: Colors.red, fontSize: 14.0))
          ],
        ),
      ),
    );
  }

  // Widget _buildIcon(DocumentSnapshot document, int index) {
  //   List productImage =document[productImages] as List;
  //  bool alreadySaved = _saved.contains(store);
  //   return IconButton(
  //     icon: Icon(
  //       alreadySaved ? Icons.favorite : Icons.favorite_border,
  //       color: alreadySaved ? Colors.red : null,
  //     ),
  //     onPressed: () {
  //       setState(() {
  //         if (alreadySaved) {
  //           _saved.remove(store[index]);
  //         } else {
  //           _saved.add(store[index]);
  //         }
  //       });
  //     },
  //   );
  // }
  // void _toggelFavourite(DocumentSnapshot document ,int index){
  //    List productImage =document[productImages] as List;
  //   final bool isCurrentFavorite = storeItems[index].isFavorited;
  //   final bool newFavoriteStatus = !isCurrentFavorite;
  //   final Store updatedProduct = Store.items(
  //     itemName: document[productTitle],
  //     itemDescription: document[productDescription],
  //     itemPrice: document[productPrice],
  //     itemImage: document[productImage[0]],
  //     itemRating: storeItems[index].itemRating,
  //     isFavorited: newFavoriteStatus
  //   );
  //   storeItems[index] = updatedProduct;

  // }
  Widget buildProducts(
      BuildContext context, int index, DocumentSnapshot document) {
    List productImage = document[productImages] as List;
    alreadySaved = _saved.contains(document[productTitle]);
    // var alreadySaved = _saved.contains(store);

    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ItemDetails(
                    itemImage: productImage[0],
                    itemImages: productImage,
                    itemName: document[productTitle],
                    itemSubname: document[productCategory],
                    itemDescription: document[productDescription],
                    itemPrice: document[productPrice],
                    itemQuantity: document[productQuantity],
                    itemType: document[productVariation],
                    //itemRating: storeItems[index].itemRating,
                  )));
        },
        child: Card(
            child:
                Stack(alignment: FractionalOffset.topLeft, children: <Widget>[
          Stack(
            alignment: FractionalOffset.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(productImage[0])),
                ),
              ),
              Card(
                elevation: 20.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  height: 60.0,
                  width: (screenSize.width - 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${document[productTitle]}..",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "N${document[productPrice]}",
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "Sale 50% off",
                        style: TextStyle(
                            color: Colors.red[400],
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 30.0,
                width: 60.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    Text(
                      "0.0",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: IconButton(
                    icon: Icon(
                        alreadySaved ? Icons.favorite : Icons.favorite_border,
                        color: alreadySaved ? Colors.red : Colors.white,
                        size: 30),
                    onPressed: () {
                      // firestore
                      //     .collection(favorites)
                      //     .document(userID)
                      //     .collection(favorites)
                      //     .document(document.documentID)
                      //     .delete();
                      addToFavorites(document, index);
                    },
                  ),
                ),
              ),
            ],
          )
        ])));
  }

  addToFavorites(document, index) async {
    String response = await appMethods.getFavorites(
      prodtTitle: document[productTitle],
      prodtVariation: document[productVariation],
      prodtCat: document[productCategory],
      prodtDesc: document[productDescription],
      prodtPrice: document[productPrice],
      itemQty: document[productQuantity].toString(),
      prodtImages: document[productImages],
    );
    if (response == successful) {
      print(response);
      setState(() {
        if (alreadySaved) {
          _saved.remove(document[productTitle]);
        
        } else {
          _saved.add(document[productTitle]);
        }
      });
      // showInSnackBar(message:"favorite",key: scaffoldKey);
    } else if (accountName == "Guest User") {
      showInSnackBar(
          message: "Please signin to favorite item", key: scaffoldKey);
    } else {}
  }

  Future getCount() async {
    if(accountName != null){
    counter = await appMethods.getCartCount();
    print(counter);
    }else{
      showInSnackBar(message:"Please sign in",key:scaffoldKey);
    }
  }
 Future _alertDialogue(BuildContext context,String message,String header)async{
  showDialog(
  context: context,
  builder:(BuildContext context){
    return AlertDialog(
      title:Text(header),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child:Text("Cancel"),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child:Text("Ok"),
          onPressed: () async {
           setState(() {
        
           });
          bool response = await appMethods.logOutUser();
           if(response == true) getCurrentUser();
            Navigator.of(context).pop(true);
          },
        )
      ],
    );
  }
);
}
}