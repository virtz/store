import 'package:flutter/material.dart';
import 'package:store/adminScreens/addCategory.dart';
import 'package:store/adminScreens/addProduct.dart';
import 'package:store/adminScreens/orderHistory.dart';
import 'package:store/adminScreens/search.dart';
import 'package:store/adminScreens/products.dart';

class AdminHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AdminHomeState();
  }
}

class _AdminHomeState extends State<AdminHome> {
  Size screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        //backgroundColor: Colors.red,
        title: Text('App Admin'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SearchData();
                      }));
                    },
                    child: CircleAvatar(
                      maxRadius: 70.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.search),
                            SizedBox(height: 10.0),
                            Text('Search'),
                          ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return AddCategory();
                      }));
                    },
                    child: CircleAvatar(
                      maxRadius: 70.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.category),
                            SizedBox(height: 10.0),
                            Text('Add Category'),
                          ]),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      maxRadius: 70.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.notifications),
                            SizedBox(height: 10.0),
                            Text('App Orders'),
                          ]),
                    ),
                  ),
                 /* CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.message),
                          SizedBox(height: 10.0),
                          Text(' Messages'),
                        ]),
                  )*/
                      GestureDetector(
                       onTap: (){
                          Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return OrderHistory();
                      }));
                       },
                        child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.history),
                            SizedBox(height: 10.0),
                            Text('Order History'),
                          ]),
                  ),
                      ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Products()));
                    },
                    child: CircleAvatar(
                      maxRadius: 70.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.shop),
                            SizedBox(height: 10.0),
                            Text('Products'),
                          ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => AddProduct())),
                    child: CircleAvatar(
                      maxRadius: 70.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.add),
                            SizedBox(height: 10.0),
                            Text('Add Product'),
                          ]),
                    ),
                  )
                ],
              ),
              
             /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              
                 CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.person),
                          SizedBox(height: 10.0),
                          Text('Privilages'),
                        ]),
                  )
                ],
          ),*/
             
            ],
          ),
        ),
      ),
    );
  }
}
