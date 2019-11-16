import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController categoryctnameController = TextEditingController();
  //TextEditingController categoryctnameController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AppMethods appMethods = FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Add Category"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton.icon(
              onPressed: () => pickImage(),
              color: Colors.green,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text("Icon", style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: appTextField(
                  textHint: "Category name",
                  textIcon: Icons.category,
                  texttype: TextInputType.text,
                  controller: categoryctnameController,
                ),
              ),
            ),
            
                Card(
                  elevation: 3.0,
             color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: iconPicked(
                    iconList: iconList,
                    removeNewImage: (index) {
                      removeImage(index);
                    }),
              ),
            ),
            SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: appButton(
                  buttonText: "Add Category",
                  buttoncolor: Colors.black,
                  btnColor: Colors.white,
                  onBtnclick: () => addCategory(),
                ),
              ),
            ),
        
          ],
        ),
      ),
    );
  }

  List<File> iconList;
  pickImage() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      List<File> imageFile = List();
      imageFile.add(file);
      if (iconList == null) {
        iconList = List.from(imageFile, growable: true);
      } else {
        for (int s = 0; s < imageFile.length; s++) {
          iconList.add(file);
        }
      }
      setState(() {});
    }
  }

  addCategory() async {
    if (iconList == null || iconList.isEmpty) {
      showSnackBar(message: "Category icon cannot be empty", key: scaffoldKey);
      return;
    }
    if (categoryctnameController.text == "") {
      showSnackBar(message: "Category name cannot be empty", key: scaffoldKey);
      return;
    }
    Map<String, dynamic> newCategory = {
      categoryName: categoryctnameController.text,
    };
    displayProgressDialog(context);
    String categoryID =
        await appMethods.addNewCategory(newCategory: newCategory);
    List<String> imageUrl =
        await appMethods.uploadCatIcon(docID: categoryID, iconAdd: iconList);
    if (imageUrl.contains(error)) {
      closeProgressDialog(context);
      resetEverything();
      showSnackBar(message: error.toString(), key: scaffoldKey);
      return;
    }
    bool result =
        await appMethods.updateCategoryIcon(docId: categoryID, data: imageUrl);
    if (result != null && result == true) {
      closeProgressDialog(context);
      showInSnackBar(message: "Category added successfully", key: scaffoldKey);
    }
  }

  void resetEverything() {
    iconList.clear();
    categoryctnameController.text = "";
    setState(() {});
  }

  void removeImage(int index) async {
    iconList.removeAt(index);
    setState(() {});
  }
}
