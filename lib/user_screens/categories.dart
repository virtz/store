import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:store/user_screens/myhomepage.dart';

class Categories extends StatefulWidget {
  final String prodtCategory;
  Categories({this.prodtCategory});
  @override
  State<StatefulWidget> createState() {
    return _CategoriesState();
  }
}

class _CategoriesState extends State<Categories> {
  AppMethods appMethods = FirebaseMethods();
  Firestore firestore = Firestore.instance;
  String prodtCategory = " ";
  var _data;
  @override
  void initState() {
    super.initState();
    _data = appMethods.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('ShopEx',
              style: TextStyle(
                  fontFamily: "Montserrat", fontStyle: FontStyle.italic)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: screenSize.width,
                height: screenSize.height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/catbackground.jpg'))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.storage),
                        SizedBox(width: 3.0),
                        Text(
                          "Porduct Category",
                          style: TextStyle(
                              fontSize: 19.0, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Divider(
                      height: 10.0,
                      indent: 10.0,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  FutureBuilder(
                    future: firestore.collection(categories).getDocuments(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      final int dataCount = snapshot.data.documents.length;
                      if (dataCount == 0 || dataCount == null) {
                        displayProgressDialog(context);
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        shrinkWrap: true,
                        itemCount: dataCount,
                        itemBuilder: (context, index) {
                          var document = snapshot.data.documents[index];
                          List categoryIcon = document[categoryImage] as List;
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return MyHomePage(
                                    prodctCategory: document[categoryName]);
                              }));
                            },
                            child: Card(
                              child: Stack(
                                alignment: FractionalOffset.bottomCenter,
                                children: <Widget>[
                                  Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(categoryIcon[0]),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      color: Colors.white,
                                      height: 55,
                                      width: screenSize.width / 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text(
                                          document[categoryName],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.0),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
