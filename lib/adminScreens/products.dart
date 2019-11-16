import 'package:flutter/material.dart';
import 'package:store/adminScreens/itemPage.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/tools/store.dart';

class Products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductState();
  }
}

class ProductState extends State<Products> {
  AppMethods appMethods = FirebaseMethods();
  Firestore firestore = Firestore.instance;
  Future _data;
  int index;
  DocumentSnapshot document;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Store> store;
  var product;
  AsyncSnapshot snapshot;

  @override
  void initState() {
    super.initState();
    _data = appMethods.getProducts();
    product = document;

    // document.data[index] as List;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          //elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Products'),
        ),
        body: Container(
          child: FutureBuilder(
            future: _data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data == null) {
                return noDataFound();
              } else {
                final int dataCount = snapshot.data.length;
                // final DocumentSnapshot document =snapshot.data.documents[index];
                if (dataCount == null || dataCount == 0) {
                  return noDataFound();
                }
                return ListView.builder(
                  itemCount: dataCount,
                  itemBuilder: (_, index) {
                    List productImage =
                        snapshot.data[index][productImages] as List;
                    return Dismissible(
                      background: stackBehindDismiss(),
                      key: ObjectKey(snapshot.data[index]),
                      onDismissed: (direction){
                        deleteProduct(context, snapshot, index);
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ItemPage(
                                    itemimage: productImage[0],
                                    itemimages: productImage,
                                    itemname: snapshot.data[index]
                                        [productTitle],
                                    itemsubname: snapshot.data[index]
                                        [productCategory],
                                    itemdescription: snapshot.data[index]
                                        [productDescription],
                                    itemPrice: snapshot.data[index]
                                        [productPrice],
                                    itemquantity: snapshot.data[index]
                                        [productQuantity],
                                    itemtype: snapshot.data[index]
                                        [productVariation],
                                    itemratings: storeItems[index].itemRating,
                                  )));
                        },
                        child: Card(
                          //color: Colors.grey,
                          child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data[index][productTitle],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    //fontStyle: FontStyle.italic
                                  ),
                                ),
                              ),
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.scaleDown,
                                          image: NetworkImage(snapshot
                                              .data[index][productImages][0])),
                                    ),
                                  ),
                                ),
                              ),
                              trailing: FlatButton(
                                textColor: Colors.black,
                                child: Text(
                                  'DELETE',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.red),
                                ),
                                onPressed: () {
                                  deleteProduct(context, snapshot, index);

                                  //String productID;
                                  // appMethods.deleteProduct(snapshot.data[index].documentID).whenComplete((){
                                  // setState((){
                                  //  items.removeAt(index);
                                  //});
                                  //});
                                },
                              )),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
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

  Widget buildList(BuildContext context, int index, DocumentSnapshot document) {
    final int dataCount = document.data.length;
    return ListView.builder(
      itemCount: dataCount,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text(document.data[index].data[productTitle]),
        );
      },
    );
  }

  deleteProduct(BuildContext context, snapshot, int index) async {
    //store = _data as List;
    //String productID = firestore.collection(appProducts).document().documentID;
    appMethods.deleteProduct(snapshot.data[index].documentID).whenComplete(() {
      setState(() {
        store.removeAt(index);
      });
    });
  }
}
