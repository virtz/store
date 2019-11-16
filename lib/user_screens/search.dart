import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/adminScreens/itemPage.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:store/user_screens/item_details.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {


var queryResultSet = [];
  var tempSearchStore = [];
  AppMethods appMethods = FirebaseMethods();

  var element;

  
   initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.length == 0 && value.length == 1) {
      appMethods.searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
      /* QuerySnapshot docs;
      if (docs.documents.length == null) {
        noDataFound();
      }*/
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['productTitle'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
            //print(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int index;
    return Scaffold(
      appBar:AppBar(
        title:Text("Search"),

      ),
      body:Container(
        child:SingleChildScrollView(
          child:Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                elevation: 20.0,
                shadowColor: Colors.black,
                child:
                 Container(
                   child: TextField(
                        onChanged: (val) {
                          initiateSearch(val);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0, top: 14.0),
                          prefixIcon: IconButton(
                            color: Theme.of(context).primaryColor,
                            icon: Icon(Icons.arrow_back),
                            iconSize: 20.0,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          hintText: "enter keyword/name",
                          // border: OutlineInputBorder(
                            
                          // ),
                        )

                        //alignLabelWithHint: true,
                        ),
                 ),
              ),
            ),
            SizedBox(height:15.0),
              GridView.count(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                primary: false,
                shrinkWrap: true,
                children: tempSearchStore.map((element) {
                  // final DocumentSnapshot document = element.data.documents;

                  return buildResultCard(element, index);
                }).toList(),
              )
          ],)
        )
      )
    );
  }
  Widget buildResultCard(data,index){
     List productImage = data[productImages] as List; 
     return GestureDetector(
         onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ItemDetails(
                  itemImage: productImage[0],
                  itemImages: productImage,
                  itemName: data[productTitle],
                  itemSubname: data[productCategory],
                  itemDescription: data[productDescription],
                  itemPrice: data[productPrice],
                  itemQuantity: data[productQuantity],
                  itemType: data[productVariation],
                 // itemratings: storeItems[index].itemRating,
                )));
      },
       child: Card(
         shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
         elevation: 7.0,
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
                  elevation:20.0,
                                child: Container(
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    height: 40.0,
                    width: 200.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "${data[productTitle].substring(0,4)}..",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black),
                          ),
                        ),
                       
                        Text(
                          "N${data[productPrice]}",
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                ),
              ],
            ),
                  ])
                  ),
     );
  }
}