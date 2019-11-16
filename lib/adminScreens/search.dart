import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/adminScreens/itemPage.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:store/tools/store.dart';

class SearchData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchDataState();
  }
}

class _SearchDataState extends State<SearchData> {
  var queryResultSet = [];
  var tempSearchStore = [];
  AppMethods appMethods = FirebaseMethods();

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
      appBar: AppBar(title: Text('Search')),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                      hintText: "Search by name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    )

                    //alignLabelWithHint: true,
                    ),
              ),
              SizedBox(height: 10.0),
              GridView.count(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                primary: false,
                shrinkWrap: true,
                children: tempSearchStore.map((element) {
                  // final DocumentSnapshot document = element.data.documents;

                  return buildResultCard(element, index);
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResultCard(data, index) {
    List productImage = data[productImages] as List;
   // double storeItem[itemRating]= data[itemRating] as String;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ItemPage(
                  itemimage: productImage[0],
                  itemimages: productImage,
                  itemname: data[productTitle],
                  itemsubname: data[productCategory],
                  itemdescription: data[productDescription],
                  itemPrice: data[productPrice],
                  itemquantity: data[productQuantity],
                  itemtype: data[productVariation],
                 // itemratings: storeItems[index].itemRating,
                )));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(530),
            image: DecorationImage(
                fit: BoxFit.fitWidth, image: NetworkImage(productImage[0])),
              
          ),
          child: Center(
            child: Text(
              data['productTitle'],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
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
            Text("No Products found yet",
                style: TextStyle(color: Colors.black45, fontSize: 20.0)),
            Text("Please check your intenet",
                style: TextStyle(color: Colors.red, fontSize: 14.0))
          ],
        ),
      ),
    );
  }
}
