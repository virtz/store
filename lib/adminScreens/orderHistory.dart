import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';

class OrderHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderHistoryState();
  }
}

class _OrderHistoryState extends State<OrderHistory> {
  Firestore firestore = Firestore.instance;
  AppMethods appMethods = FirebaseMethods();
  FirebaseAuth auth = FirebaseAuth.instance;
  var _data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }
  @override
  Widget build(BuildContext context) {
    
   // userid = userID;
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(title: Text('Order history'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon:Icon(Icons.refresh),
                onPressed:(){
                  setState(() {
                   
                   }); 
                  
                  
                },
              ),
            ),
          ]),
        body: StreamBuilder(
          stream: firestore.collection(orderCollection).orderBy(created).snapshots(),
          builder: (context,snapshot){
           if(!snapshot.hasData){
             return Container(
               child: Center(
                 child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                 ),
               ),
             );
           } else {
             final int dataCount = snapshot.data.documents.length;
             print("data count $dataCount");
             if(dataCount == 0||auth == null){
               return noDataFound();

             }else {
               return GridView.builder(
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,

                 ),
                 itemCount:dataCount,
                 itemBuilder: (context,index){
                   final DocumentSnapshot document = snapshot.data.documents[index];
                   return buildList(context, index, document);
                 },
               );
             }
           }
          },
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
            Text("Could not load order history",
                style: TextStyle(color: Colors.black45, fontSize: 20.0)),
            Text("Please check back later",
                style: TextStyle(color: Colors.red, fontSize: 14.0))
          ],
        ),
      ),
    );
   
  }
 Widget buildList(BuildContext context,int index, DocumentSnapshot document){
   return Card(
     
     child:Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: <Widget>[
         Padding(
           padding: const EdgeInsets.only(top:12.0,bottom:8.0,left:8.0,right:8.0),
           child: Row(
             mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
             children: <Widget>[
               Text("ProductTitle :",style: TextStyle(
                 fontWeight: FontWeight.w600,
               ),),
               Text(document.data[productTitle],
               style: TextStyle(
                 color: Colors.blue,
                 fontWeight: FontWeight.w800,
                 fontSize: 15.0
               ),),
             ],
           ),
         
         ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
               children: <Widget>[
                 Text("Quantity   :",style: TextStyle(
                   fontWeight: FontWeight.w600,
                 ),),
                 Text(document.data[itemQuantity],style: TextStyle(fontWeight: FontWeight.bold),),
               ],),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment:MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(left:10.0,),
                   child: Text("Variation   :",style: TextStyle(
                     fontWeight: FontWeight.w600,
                   ),),
                 ),
                 Text(document.data[productVariation],style:TextStyle(
                   fontWeight: FontWeight.bold,
                 ))
               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment:MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(left:10.0),
                   child: Text("Price  :",style: TextStyle(
                     fontWeight: FontWeight.w600,
                   ),),
                 ),
                 Text("N${document.data[productPrice]}",style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.w800
                 ),)
               ],
             ),
           ),
           appButton(
              buttonText: 'View More',
              buttonPadding: 1.0,
              buttoncolor: Colors.black,
              onBtnclick: ()=>showDialog(
                context: context,
                builder:(context) =>_dialogBuilder(context, document)
              ),
                
              ),
       ],
     ) ,
   );
 }
 Widget _dialogBuilder(BuildContext context,DocumentSnapshot document){
   return SimpleDialog(
     children: <Widget>[
       Container(
         width:150.0,
         height: 50.0,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
               Text("Order Date :",style: TextStyle(fontWeight: FontWeight.w500),),
               Text(document.data[created].toString())
             ],
           ),
         ),
       )
     ],
   );
 }
}
