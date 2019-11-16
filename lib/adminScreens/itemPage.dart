import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/user_screens/cart.dart';

class ItemPage extends StatefulWidget{
  String itemname;
  String itemsubname;
  String itemimage;
  String itemdescription;
  String itemPrice;
  List itemimages;
  String itemquantity;
  String itemtype;
  double itemratings;

  ItemPage({
    this.itemname,
    this.itemsubname,
    this.itemimage,
    this.itemdescription,
    this.itemPrice,
    this.itemimages,
    this.itemquantity,
    this.itemratings,
    this.itemtype,
  });
  @override
  State<StatefulWidget> createState() {
   
    return _ItemPageState();
  }

  
}
class _ItemPageState extends State<ItemPage>{
  @override
  Widget build(BuildContext context) {
    
       Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        iconTheme: IconThemeData(color:Colors.white),
      ),
  body: Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      Container(
        height: 300.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.itemimage),
            fit: BoxFit.fitHeight
          ),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(120.0),
            bottomLeft: Radius.circular(120.0),
          )
        ),
      ),
            Container(
        height: 300.0,
        decoration: BoxDecoration(
        color: Colors.grey.withAlpha(50),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(120.0),
            bottomLeft: Radius.circular(120.0),
          )
        ),
      ),
      SingleChildScrollView(
        padding: const EdgeInsets.all(0.0),
        child: Column(children: <Widget>[
          SizedBox(height: 50.0,),
          Card(
            child: Container(
              width: screenSize.width,
              margin:EdgeInsets.only(left:20.0, right:20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Text(widget.itemname,
                  style:TextStyle(
                    fontSize:18.0,
                    fontWeight: FontWeight.w700 )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(widget.itemsubname,
                    style: TextStyle(fontSize: 14.0,
                    fontWeight: FontWeight.w700),),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:<Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.star,
                      color:Colors.blue,
                      size:20.0),
                     
                      Text("${0.0}"),
                        
                    ],
                  ),
                   SizedBox(height: 20.0),
                  Row(
                    children:<Widget>[
                      Text("N${widget.itemPrice}",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),)
                    ]),
                ],
              ),
                SizedBox(height: 20.0,)
                ]), 
            ),
        ),
        Card(
          child: Container(
            width: screenSize.width,
            height: 150.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.itemimages.length,
              itemBuilder: (context, index){
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left:5.0, right: 5.0),
                      height: 140.0,
                      width: 100.0,
                      child: Image.network(widget.itemimages[index]),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:5.0, right:5.0),
                      height: 140.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(50)
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ),
        Card(
          child:Container(
            width: screenSize.width,
            margin: EdgeInsets.only(left:20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Text('Description',
                style:TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700
                )),
                SizedBox(
                  height: 10.0,
                ),
                Text(widget.itemdescription,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                )),
                SizedBox(
                  height: 10.0,
                ),

            ],)
          )
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
                
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Column(
                       children: <Widget>[
                         Text('Quantity',
                          style:TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          )),
                            SizedBox(height: 10.0,),
                       Text(widget.itemquantity),
                       ],
                     ),
                    
              
               
                Column(
                  children: <Widget>[
                    Text('Variations',
                    style:TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    )),
                      SizedBox(
                  height: 10.0,
                ),
                    Text(widget.itemtype),
                SizedBox(height:10.0),
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
                /*Text('Quantity',
                style:TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                )),*/
                SizedBox(
                  height: 10.0,
                ),
              /* Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   new CircleAvatar(
                     child:IconButton(
                       icon: Icon(Icons.remove),
                       onPressed: ()=>_decrementCounter(),
                     ),
                   ),
                   Text('$iquantity',
                   style: TextStyle(fontSize:16.0,
                   fontWeight: FontWeight.w400, 
                   ),),
                   CircleAvatar(
                     child: IconButton(
                       icon:Icon(Icons.add) ,
                     onPressed:()=>_incrementCounter(),
                     ),
                   ),
                 ],
               ),*/
              
              ],
            ),
          ),
        )
        ]),
        
      )
    ],
  ),  /* floatingActionButton: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return Cart();
              }));
            },
            child: Icon(Icons.shopping_cart),
          ),
          CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: Text(
              '0',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
  ]
  ),*/
        
   
    
  
  
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width:(screenSize.width - 20)/2,
                
                child: Text('EDIT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.w700,
                ),),
              ), 
               Container(
                width:(screenSize.width - 20)/2,
                child: Text('DELETE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.w700,
                ),),
              ),
            ],
          ),
        ),
          ),

        );
  
  }

}

