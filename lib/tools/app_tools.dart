import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store/tools/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget appTextField(
    {IconData textIcon,
    String textHint,
    bool isPassword,
    IconData textIcon2,
    double sidePadding,
    double sidealignment,
    TextInputType texttype,
    TextEditingController controller,
      onChange  }) {
  sidePadding == null ? sidePadding = 0.0 : sidePadding;
  textHint == null ? textHint = "" : textHint;
  texttype == null ? texttype = TextInputType.text : texttype;
  //sidealignment == null ? sidealignment = 0.0 : sidealignment;

 
    return Padding(
      padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: TextField(
          onChanged: onChange,
                controller: controller,
                obscureText: isPassword == null ? false : isPassword,
                keyboardType: texttype,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: textHint,
                  prefixIcon: textIcon == null ? Column() : Icon(textIcon),
                  //suffixIcon: textIcon2 == null?Container():Icon(textIcon2),
                ),
              ),
            ),
          );
        }
        

        Widget appTextField2(
    {IconData textIcon,
    String textHint,
    bool isPassword,
    IconData textIcon2,
    double sidePadding,
    double sidealignment,
    TextInputType texttype,
    TextEditingController controller,
    VoidCallback onTap,
      onChange  }) {
  sidePadding == null ? sidePadding = 0.0 : sidePadding;
  textHint == null ? textHint = "" : textHint;
  texttype == null ? texttype = TextInputType.text : texttype;
  //sidealignment == null ? sidealignment = 0.0 : sidealignment;

 
    return Padding(
      padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
      child: Container(
       
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left:15.0),
          child: TextField(
            onChanged: onChange,
                  controller: controller,
                  obscureText: isPassword == null ? false : isPassword,
                  keyboardType: texttype,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: textHint,
                    suffixIcon: textIcon == null ? Column() : Icon(textIcon),
                    
                    
                  ),
                ),
        ),
            ),
          );
        }
        Widget productTextField(
            {String textTitle,
            String texHint,
            double height,
            Color boxColor,
            TextEditingController controller,
            int maxlines,
            TextInputType textType}) {
          //sidePadding == null ? sidePadding = 0.0 :sidePadding;
          // textType == null ? textType = TextInputType.text: textType;
          texHint == null ? texHint = "Emter hint" : texHint;
          height == null ? height = 50.0 : height;
        
          textTitle == null ? textTitle = "Enter Title" : textTitle;
          return Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(textTitle,
        
                      style:
                          TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    height: height,
                    //color: textColor,
                    decoration: BoxDecoration(
                      color: boxColor,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextField(
                          controller: controller,
                          keyboardType: textType == null
                              ? textType = TextInputType.text
                              : textType,
                              maxLines:maxlines == null? null:maxlines ,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: texHint,
                          ),
                        )),
                  ),
                )
              ]);
        }
        
        Widget productDropDown(
            {String selectedItem,
            String textTitle,
            List<DropdownMenuItem<String>> dropDownItems,
            ValueChanged <String>changeDropDownItems}) {
               textTitle == null ? textTitle = "Enter Title" : textTitle;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(textTitle,
                    style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right : 15.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        //style: TextStyle(),
                        value: selectedItem,
                        items: dropDownItems,
                        onChanged: changeDropDownItems,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        
        Widget appButton(
            {String buttonText,
            double buttonPadding,
            Color buttoncolor,
            Color btnColor,
            VoidCallback onBtnclick}) {
          buttonText == null ? buttonText == 'App Button' : buttonText;
          buttonPadding == null ? buttonPadding = 0.0 : buttonPadding;
          buttoncolor == null ? buttoncolor = Colors.teal : buttoncolor;
          btnColor == null ? btnColor = Colors.white : btnColor;
        
          return Padding(
            padding: EdgeInsets.all(buttonPadding),
            child: RaisedButton(
                onPressed: onBtnclick,
                color: btnColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Container(
                  height: 45.0,
                  child: Center(
                    child: Text(buttonText,
                        style: TextStyle(color: buttoncolor, fontSize: 15.0)),
                  ),
                )),
          );
        }
        List<DropdownMenuItem<String>> buildGetDropDownQuantity(List size){
          List<DropdownMenuItem<String>> items = List();
          for(String size in size){
            items.add(DropdownMenuItem(value: size,child:Text(size),));
          }
          return items;
        }
        Widget multiImagePickerList({List<File> imageList, VoidCallback removeNewImage(int position)}){
        return Padding(
          padding: const EdgeInsets.only(left:15.0, right: 15.0),
          child: imageList == null || imageList.length == 0
          ? Container():
           SizedBox(height: 150.0,
           child: ListView.builder(
             itemCount: imageList.length,
             scrollDirection: Axis.horizontal,
             itemBuilder: (context, index){
               return Padding(
                 padding: EdgeInsets.only(left: 3.0, right :3.0),
                 child: Stack(children: <Widget>[
                   Container(width: 150.0,
                   height: 150.0,
                   decoration:BoxDecoration(
                     color: Colors.grey.withAlpha(100),
                     borderRadius: BorderRadius.all(
                       Radius.circular(15.0)
                     ),
                     image: DecorationImage(
                       image: FileImage(imageList[index]),
                       fit: BoxFit.cover,
                     )
                   ) ,),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: CircleAvatar(
                       backgroundColor: Colors.red[600],
                       child:IconButton(
                         icon: Icon(Icons.clear,
                         color: Colors.white,),
                         onPressed: (){
                           removeNewImage(index);
                         },
                       )
                     ),
                   )
                 ],
               ),
               );
             }),),
        );
        }
        
        Widget iconPicked({List<File> iconList, VoidCallback removeNewImage(int position)}){
          return Padding(
          padding: const EdgeInsets.only(left:15.0, right: 15.0),
          child: iconList == null || iconList.length == 0
          ? Container():
           SizedBox(height: 150.0,
           child: ListView.builder(
             itemCount: iconList.length,
             scrollDirection: Axis.horizontal,
             itemBuilder: (context, index){
               return Padding(
                 padding: EdgeInsets.only(left: 3.0, right :3.0),
                 child: Stack(children: <Widget>[
                   Container(width: 150.0,
                   height: 150.0,
                   decoration:BoxDecoration(
                     color: Colors.grey.withAlpha(100),
                     borderRadius: BorderRadius.all(
                       Radius.circular(15.0)
                     ),
                     image: DecorationImage(
                       image: FileImage(iconList[index]),
                       fit: BoxFit.cover,
                     )
                   ) ,),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: CircleAvatar(
                       backgroundColor: Colors.red[600],
                       child:IconButton(
                         icon: Icon(Icons.clear,
                         color: Colors.white,),
                         onPressed: (){
                           removeNewImage(index);
                         },
                       )
                     ),
                   )
                 ],
               ),
               );
             }),),
        );
        }
        showSnackBar({BuildContext context, final key, String message}) {
          message == null ? message == " " : message;
          key.currentState.showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            content: Text(message, style: TextStyle(color: Colors.white)),
          ));
        }
          
        showInSnackBar({BuildContext context, final key, String message}) {
          message == null ? message == "No message " : message;
          key.currentState.showSnackBar(new SnackBar(
            backgroundColor: Colors.green,
            content: Text(message, style: TextStyle(color: Colors.white)),
          ));
        }
        displayProgressDialog(BuildContext context) {
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return ProgressDialog();
              }));
        }
        
        closeProgressDialog(BuildContext context) {
          Navigator.of(context).pop();
        }
        
        writeDataLocally({String key, String value}) async {
          Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
          final SharedPreferences localData = await saveLocal;
          localData.setString(key, value);
        }
        
        writeBoolDataLocally({String key, bool value}) async {
          Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
          final SharedPreferences localData = await saveLocal;
          localData.setBool(key, value);
        }
        
        getDataLocally({String key}) async {
          Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
          final SharedPreferences localData = await saveLocal;
          return localData.get(key);
        }
        
        getBoolDataLocally({String key}) async {
          Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
          final SharedPreferences localData = await saveLocal;
          return localData.getBool(key) == null ? false : localData.getBool(key);
        }
        
        getStringDataLocally({String key}) async {
          Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
          final SharedPreferences localData = await saveLocal;
          return localData.getString(key);
        }
        
        clearDataLocally() async {
          Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
          final SharedPreferences localData = await saveLocal;
          localData.clear();
        }
          void selectedProduct(int index){
          var _selectedProductIndex = index;
        }
   

    Widget _ackAlert(BuildContext context,String message,String header){
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
   
    }