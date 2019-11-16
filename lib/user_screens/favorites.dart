import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/appData.dart' as prefix0;
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:store/tools/store.dart';
import 'package:store/user_screens/item_details.dart';

class Favorites extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoritesState();
  }
}

class _FavoritesState extends State<Favorites> {
  AppMethods appMethods = FirebaseMethods();
  Firestore firestore = Firestore.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future _data;

  List store;

  @override
  void initState() {
    super.initState();
    _data = appMethods.getFav(userID);
  }

  @override
  Widget build(BuildContext context) {
    var userid;
    userid = appMethods.getCurrentUser(userid);

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Favorites'),
          //centerTitle: true,
        ),
        body: Container(
            child: FutureBuilder(
          future: _data,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            final int dataCount = snapshot.data.documents.length;
              if(dataCount== 0){
                return NodataFound();
              }
            return ListView.builder(
              itemCount: dataCount,
              itemBuilder: (context, index) {
                List productImage =
                    snapshot.data.documents[index][productImages] as List;
                final DocumentSnapshot document =
                    snapshot.data.documents[index];
                return Dismissible(
                  background: stackBehindDismiss(),
                  key: ObjectKey(document),
                  onDismissed: (direction) {
                    //firestore.collection(favorites).document().delete();
                    deleteProduct(context, document, index);
                  },
                  child: GestureDetector(
                       onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ItemDetails(
                    itemImage: productImage[0],
                    itemImages: productImage,
                    itemName: document[productTitle],
                    itemSubname: document[productCategory],
                    itemDescription: document[productDescription],
                    itemPrice: document[productPrice],
                    itemQuantity: document[itemQuantity],
                    itemType: document[productVariation],
                    itemRating: storeItems[index].itemRating,
                  )));
        },
                                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          elevation: 5.0,
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
                                        child: Text("N${document[productPrice]}",style:TextStyle(fontSize:15.0))),
                                    SizedBox(height: 10.0),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(document[productVariation])),
                                        SizedBox(height:10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Colors.red,
                                          size: 20.0,
                                        ),
                                        SizedBox(height:5.0),
                                        Padding(
                                          padding: const EdgeInsets.only(left:6.0),
                                          child: Text(
                                            "0.0",
                                            style: TextStyle(color: Colors.
                                            black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                );
              },
            );
          },
        )));
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

  deleteProduct(BuildContext context, document, int index) async {
    //String productID = firestore.collection(appProducts).document().documentID;
    appMethods.deleteFavorite(document.documentID).whenComplete(() {
      // setState(() {
      // store.removeAt(index) ;
      // });
    }).whenComplete(() {
      print("success");
    });
  }
}

class NodataFound extends StatelessWidget {
  const NodataFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.find_in_page, color: Colors.black38, size: 80.0),
            Text("Could not load favorites",
                style: TextStyle(color: Colors.black45, fontSize: 20.0)),
            Text("Please check your internet connection",
                style: TextStyle(color: Colors.red, fontSize: 15.0))
          ],
        ),
      ),
    );
  }
}
