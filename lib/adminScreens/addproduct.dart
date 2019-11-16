import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/app_tools.dart';
import 'package:store/tools/firebase_methods.dart';

class AddProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddProductState();
  }
}

class _AddProductState extends State<AddProduct> {
  List<DropdownMenuItem<String>> _dropDownQuantity;
  String _selectedQuantity;
  List<String> quantityList = List();

  List<DropdownMenuItem<String>> _dropDownVariation;
  String _selectedVariation;
  List<String> variationList = List();

  List<DropdownMenuItem<String>> _dropDownCategory;
  String _selectedCategory;
  List<String> categoryList = List();

  Map<int, File> imageMap = Map();
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController prdSearchController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    quantityList = List.from(localQuantity);
    variationList = List.from(localVariation);
    categoryList = List.from(localCategory);
    _dropDownCategory = buildGetDropDownQuantity(categoryList);
    _dropDownQuantity = buildGetDropDownQuantity(quantityList);
    _dropDownVariation = buildGetDropDownQuantity(variationList);
    _selectedQuantity = _dropDownQuantity[0].value;
    _selectedVariation = _dropDownVariation[0].value;
    _selectedCategory = _dropDownCategory[0].value;

    
    
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(' Add Products'),
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton.icon(
                onPressed: () => pickImage(),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                icon: Icon(Icons.add, color: Colors.white),
                label: Text('Images', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              multiImagePickerList(
                  imageList: imageList,
                  removeNewImage: (index) {
                    removeImage(index);
                  }),
              productTextField(
                controller: productTitleController,
                boxColor: Colors.white,
                textTitle: "Product Title",
                texHint: "Enter Product Title",
              ),
              SizedBox(height: 10.0),
              productTextField(
                controller: productPriceController,
                boxColor: Colors.white,
                textTitle: "Product Price",
                texHint: "Enter Product Price",
                textType: TextInputType.number,
              ),
              SizedBox(
                height: 10.0,
              ),
              productTextField(
                controller: productDescController,
                boxColor: Colors.white,
                textTitle: "Product Description",
                texHint: "Enter Product Description",
                height: 180.0,
                maxlines: 4,
              ),
              SizedBox(
                height: 10.0,
              ),
              productTextField(
                textTitle: "Search Key",
                boxColor: Colors.white,
                controller: prdSearchController,
                texHint: "Enter first letter of Product Title"
              ),
              SizedBox(
                height: 10.0,
              ),
        productDropDown(
                textTitle: "Product Category",
                selectedItem: _selectedCategory,
                dropDownItems: _dropDownCategory,
                changeDropDownItems: changedDropDownCategory,
              ),
             
              SizedBox(
                height: 10.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    productDropDown(
                      textTitle: "Quantity",
                      selectedItem: _selectedQuantity,
                      dropDownItems: _dropDownQuantity,
                      changeDropDownItems: changedDropDownQuantity,
                    ),
                    productDropDown(
                      textTitle: "Variation",
                      selectedItem: _selectedVariation,
                      dropDownItems: _dropDownVariation,
                      changeDropDownItems: changedDropDownVariation,
                    ),
                  ]),
              SizedBox(
                height: 20.0,
              ),
              appButton(
                  buttonText: 'Add Product',
                  buttonPadding: 15.0,
                  buttoncolor: Colors.black,
                  onBtnclick: () {
                    addNewProduct();
                  }),
            ],
          ),
        ));
  }

  void changedDropDownQuantity(String selectedSize) {
    setState(() {
      _selectedQuantity = selectedSize;
      print(selectedSize);
    });
  }

  AppMethods appMethods = FirebaseMethods();

  void changedDropDownVariation(String selectedSize) {
    setState(() {
      _selectedVariation = selectedSize;
      print(selectedSize);
    });
  }

  void changedDropDownCategory(String selectedSize) {
    setState(() {
      _selectedCategory = selectedSize;
      print(selectedSize);
    });
  }

  List<File> imageList;
  pickImage() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      List<File> imageFile = List();
      imageFile.add(file);
      if (imageList == null) {
        imageList = List.from(imageFile, growable: true);
      } else {
        for (int s = 0; s < imageFile.length; s++) {
          imageList.add(file);
        }
      }
      setState(() {});
    }
  }

  addNewProduct() async {
    if (imageList == null || imageList.isEmpty) {
      showSnackBar(message: "Product images cannot be empty", key: scaffoldKey);
      return;
    }
    if (productTitleController.text == ""|| productTitleController.text.length < 5) {
      showSnackBar(message: "Product title cannot be empty or product title is too short", key: scaffoldKey);
      return;
    }
    if (productPriceController.text == "") {
      showSnackBar(message: "Product price cannot be empty", key: scaffoldKey);
      return;
    }
    if (productDescController.text == "" || productDescController.text.length < 10 ) {
      showSnackBar(
          message: "Product description cannot be empty or product description is too short", key: scaffoldKey);
      return;
    }if(prdSearchController.text == ""){
      showSnackBar(message:"Please enter search key",key: scaffoldKey);
      return;
    }
    if (_selectedCategory == "Select product category") {
      showSnackBar(message: "Please select a valid category", key: scaffoldKey);
      return;
    }
    if (_selectedQuantity == "Select a quantity") {
      showSnackBar(message: "Please select a valid qauntity", key: scaffoldKey);
      return;
    }
    if (_selectedVariation == "Select a type") {
      showSnackBar(message: "Please select a valid type", key: scaffoldKey);
      return;
    }
    //get text from individual controllers
   // Map<String,dynamic> newProduct;
    Map<String, dynamic> newProduct = {
      productTitle: productTitleController.text,
      productPrice: productPriceController.text,
      productDescription: productDescController.text,
      searchKey:prdSearchController.text,
      productCategory: _selectedCategory,
      productQuantity: _selectedQuantity,
      productVariation: _selectedVariation,


    };
    //show progress dialog
    displayProgressDialog(context);
   
    

    //adding to firebase
    
    String productID = await appMethods.addNewProduct(newProduct:newProduct);

    List<String> imageUrl = await appMethods.uploadProductImages(
        docID: productID, imageList: imageList);

    //checking if an error occurred while adding images to firebase
    if (imageUrl.contains(error)) {
      closeProgressDialog(context);
      showSnackBar(message: error.toString(), key: scaffoldKey);
      return;
    }
    
    bool result =
        await appMethods.updateProductImages(docID: productID, data: imageUrl);
    if (result != null && result == true) {
      closeProgressDialog(context);
      resetEverything();
      showSnackBar(message: "Product added successfully", key: scaffoldKey);
    } else {
      closeProgressDialog(context);
      showSnackBar(message: error.toString(), key: scaffoldKey);
    }
  }

  void resetEverything() {
    imageList.clear();
    productTitleController.text = "";
    productPriceController.text = "";
    productDescController.text = "";
    prdSearchController.text = "";
    _selectedCategory = "Select product category";
    _selectedQuantity = "Select a quantity";
    _selectedVariation = "Select a type";
    setState(() {
      
    });
  }

  void removeImage(int index) async {
    imageList.removeAt(index);
    setState(() {});
  }
}
