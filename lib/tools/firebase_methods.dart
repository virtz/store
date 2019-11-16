import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/tools/app_methods.dart';
import 'appData.dart';
import 'package:store/tools/app_tools.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseMethods implements AppMethods {
  Firestore firestore = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  ///AuthCredential credential ;

  //FirebaseFirestore firestore = FirebaseFirestore.getInstance();
  //FirebaseFirestoreSettings settings = new FirebaseFirestoreSettings.Builder()
  // .setTimestampsInSnapshotsEnabled(true)
  //.build();
  //firestore.setFirestoreSettings(settings);

  @override
  Future<String> createUser(
      {String fullname, String phone, String email, String password}) async {
    FirebaseUser user;

    try {
      user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        await firestore.collection(userData).document(user.uid).setData({
          userID: user.uid,
          fullName: fullname,
          userEmail: email,
          userPassword: password,
          phoneNumber: phone,
        });
        writeDataLocally(key: userID, value: user.uid);
        writeDataLocally(key: fullname, value: fullname);
        writeDataLocally(key: userEmail, value: userEmail);
        writeDataLocally(key: userPassword, value: password);

        // return successfulMSG();

      }
    } on PlatformException catch (e) {
      //print(e.details);
      return errorMSG(e.message);
    }

    return user == null ? errorMSG("Error") : successfulMSG();
  }

  @override
  Future<String> loginUser({String email, String password}) async {
    FirebaseUser user;
    try {
      user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      DocumentSnapshot userInfo = await getUserInfo(user.uid);
      if (user != null && userInfo != null) {
        await writeDataLocally(key: userID, value: userInfo[userID]);
        await writeDataLocally(key: fullName, value: userInfo[fullName]);
        await writeDataLocally(key: userEmail, value: userInfo[userEmail]);
        await writeDataLocally(key: phoneNumber, value: userInfo[phoneNumber]);
        await writeDataLocally(key: photoUrl, value: userInfo[photoUrl]);
        await writeBoolDataLocally(key: loggedIn, value: true);

        print(userInfo[userEmail]);
      }
    } on PlatformException catch (e) {
      //print(e.details);
      return errorMSG(e.message);
    }

    return user == null ? errorMSG("Error") : successfulMSG();
  }

  Future<bool> notComplete() async {
    return false;
  }

  Future<bool> complete() async {
    return true;
  }

  Future<String> successfulMSG() async {
    return successful;
  }

  Future<String> errorMSG(String e) async {
    return e;
  }

  @override
  Future<bool> logOutUser() async {
    await auth.signOut();
    await clearDataLocally();

    return complete();
  }

  @override
  Future<DocumentSnapshot> getUserInfo(String userid) async {
    // TODO: implement getUserInfo
    return await firestore.collection(userData).document(userid).get();
  }

  @override
  Future<String> addNewProduct({Map newProduct}) async {
    String documentID;
    try {
      await firestore
          .collection(appProducts)
          .add(newProduct)
          .then((documentRef) {
        documentID = documentRef.documentID;
      });
    } on PlatformException catch (e) {
      print(e.details);
    }
    return documentID;
  }

  @override
  Future<List<String>> uploadProductImages(
      {List<File> imageList, String docID}) async {
    List<String> imageUrl = List();
    try {
      for (int s = 0; s < imageList.length; s++) {
        StorageReference storageReference = FirebaseStorage.instance
            .ref()
            .child(appProducts)
            .child(docID)
            .child(docID + "$s.jpg");
        StorageUploadTask uploadTask = storageReference.putFile(imageList[s]);
        StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
        String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        imageUrl.add(downloadUrl.toString());
      }
    } on PlatformException catch (e) {
      imageUrl.add(error);
      print(e.details);
    }
    return imageUrl;
  }

  @override
  Future<bool> updateProductImages({String docID, List<String> data}) async {
    bool msg;
    await firestore
        .collection(appProducts)
        .document(docID)
        .updateData({productImages: data}).whenComplete(() {
      msg = true;
    });
    return msg;
  }

  @override
  Future getProducts() async {
    QuerySnapshot qn = await firestore.collection(appProducts).getDocuments();
    return qn.documents;
  }

  /* @override
  Future deleteProduct({String docID}) {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(firestore.collection(appProducts).document(docID));
      await tx.delete(ds.reference);
      return {'deleted': true};
    };
    return firestore
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error:$error');
      return false;
    });
  }*/

  @override
  Future<DocumentSnapshot> getProductID(String prdID) async {
    return await firestore.collection(appProducts).document(prdID).get();
  }

  @override
  Future deleteProduct(String docID) async {
    //bool msg;
    Future result = await firestore
        .collection(appProducts)
        .document(docID)
        .delete()
        .then((msg) {})
        .catchError((e) {
      print(e);
    });

    return result;
  }

  @override
  Future getUsers() async {
    QuerySnapshot qn = await firestore.collection(userData).getDocuments();
    return qn.documents;
  }

  Future getCart() async {
    FirebaseUser user;
    String userid;
    QuerySnapshot qn;
    user = await auth.currentUser();
    try {
      userid = user.uid;

      qn = await firestore.collection(cart).getDocuments();
    } on PlatformException catch (e) {
      print(e.message);
    }
    return qn.documents;
  }

  @override
  Future searchByName(String searchField) {
    return firestore
        .collection(appProducts)
        .where(searchKey, isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

  @override
  Future<String> userOrder(
      {String userid,
      String prodtTitle,
      String prodtVariation,
      String prodtPrice,
      String itemQty,
      String date}) async {
    FirebaseUser user;
    try {
      user = await auth.currentUser();
      userid = user.uid;
      // print(userid);

      if (user != null) {
        await firestore.collection(orderCollection).document().setData({
          userID: user.uid,
          productTitle: prodtTitle,
          productVariation: prodtVariation,
          productPrice: prodtPrice,
          itemQuantity: itemQty,
          created: date,
        });
        print(userid);
      }
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }
    return user == null ? errorMSG("Error") : successfulMSG();
  }

  @override
  getOrderHistorybyId(String userID) async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    //userId = userID;
    if (user != null) {
      CollectionReference col = firestore.collection(orderCollection);
      Query nameQuery = col.where("userID", isEqualTo: uid);
      return nameQuery.getDocuments();
  }
  }
  
  getCollectionLength(int number) async {
    var long = firestore.collection(appProducts).snapshots().length;
    return long;
  }

  @override
  Future getCurrentUser(String userid) async {
    try {
      FirebaseUser user;
      user = await FirebaseAuth.instance.currentUser();
      userid = user.uid;
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Future<String> userCart(
      {String userid,
      String prodtTitle,
      String prodtVariation,
      String prodtPrice,
      String itemQty,
      List prodtImages}) async {
    String msg;
    FirebaseUser user;

    try {
      String user_id;
      user = await auth.currentUser();
      userid = user.uid;
      if (user != null) {
        await firestore.collection(cart).add({
          userID: user.uid,
          productTitle: prodtTitle,
          productVariation: prodtVariation,
          productPrice: prodtPrice,
          itemQuantity: itemQty,
          productImages: prodtImages,
        }).whenComplete(() {
          msg = successful;
          print(msg);
        });
      }
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }

    return msg == null ? errorMSG("Error") : successfulMSG();
  }

  @override
  Future<String> getFavorites(
      {String userid,
      String isFavorited,
      String prodtDesc,
      String prodtCat,
      String prodtTitle,
      String prodtVariation,
      String prodtPrice,
      String itemRating,
      String itemQty,
      List prodtImages}) async {
    FirebaseUser user;
    String msg;
    try {
      user = await auth.currentUser();
      userid = user.uid;
      if (user != null && userid == user.uid) {
        await firestore.collection(favorites).add({
          userID: user.uid,
          productTitle: prodtTitle,
          productVariation: prodtVariation,
          productPrice: prodtPrice,
          productCategory: prodtCat,
          itemQuantity: itemQty,
          productDescription: prodtDesc,
          productImages: prodtImages,
        }).whenComplete(() {
          msg = successful;
        });
      } else {}
    } on Exception catch (e) {
      return errorMSG(e.toString());
    }

    return msg == null ? errorMSG("Error") : successfulMSG();
  }

  @override
  Stream<QuerySnapshot> search() {
    Query nameQuery;
    try {
      CollectionReference col = firestore
          .collection(favorites)
          .document(userID)
          .collection(favorites);
      nameQuery = col.where("true", isEqualTo: "true");
    } on PlatformException catch (e) {
      print(e);
    }
    return nameQuery.snapshots();
  }

  @override
  Future deleteFavorite(String docID) async {
    Future result = await firestore
        .collection(favorites)
        .document(docID)
        .delete()
        .then((msg) {})
        .catchError((e) {
      print(e);
    });

    return result;
  }

  @override
  Future getFav(String userid) async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    //userId = userID;
    CollectionReference col = firestore.collection(favorites);
    Query nameQuery = col.where("userID", isEqualTo: uid);
    return nameQuery.getDocuments();
  }

  @override
  Future deleteFromCart(String docID) async {
    Future result = await firestore
        .collection(cart)
        .document(docID)
        .delete()
        .then((msg) {})
        .catchError((e) {
      print(e);
    });

    return result;
  }

  @override
  Future getUserCart(String userid) async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    //userId = userID;
    if (user != null) {
      CollectionReference col = firestore.collection(cart);
      Query nameQuery = col.where("userID", isEqualTo: uid);
      return nameQuery.getDocuments();
    }
  }

  @override
  getCartCount() async {
    final FirebaseUser user = await auth.currentUser();
    List<DocumentSnapshot> _myDocCount = [];
    if (user != null && _myDocCount != null) {
      final uid = user.uid;
      QuerySnapshot _myDoc = await Firestore.instance
          .collection(cart)
          .where("userID", isEqualTo: uid)
          .getDocuments();
      _myDocCount = _myDoc.documents;
      print(_myDocCount.length);
    }
    return _myDocCount.length;
  }

  @override
  Future loadProducts(productCategory) async {
    CollectionReference col = firestore.collection(appProducts);
    Query nameQuery = col.where("productCategory", isEqualTo: productCategory);
    return nameQuery.snapshots();
  }

  @override
  Future<String> addNewCategory({Map newCategory}) async {
    String documentID;
    try {
      await firestore
          .collection(categories)
          .add(newCategory)
          .then((documentRef) {
        documentID = documentRef.documentID;
      });
    } on PlatformException catch (e) {
      print(e.details);
    }
    return documentID;
  }

  @override
  Future<List<String>> uploadCatIcon({List<File> iconAdd, String docID}) async {
    List<String> imageUrl = List();
    try {
      for (int s = 0; s < iconAdd.length; s++) {
        StorageReference storageReference = FirebaseStorage.instance
            .ref()
            .child(categories)
            .child(docID)
            .child(docID + "$s.jpg");
        StorageUploadTask uploadTask = storageReference.putFile(iconAdd[s]);
        StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
        String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        imageUrl.add(downloadUrl.toString());
      }
    } on PlatformException catch (e) {
      imageUrl.add(error);
      print(e.details);
    }
    return imageUrl;
  }

  @override
  Future<bool> updateCategoryIcon({String docId, List<String> data}) async {
    bool msg;
    await firestore
        .collection(categories)
        .document(docId)
        .updateData({categoryImage: data}).whenComplete(() {
      msg = true;
    });
    return msg;
  }

  @override
  Future getCategory() async {
    QuerySnapshot qn = await firestore.collection(appProducts).getDocuments();
    return qn.documents;
  }

  @override
  Future<bool> changePassword(
      {String eMail, String currentpassword, String passWord}) async {
    var msg;
    String message;
    FirebaseUser user;
    var response;
    try {
      user = await auth.currentUser();
      response =reauthenticate(userEmail: eMail, currentPassword: currentpassword)
          .whenComplete(() {
            if(response != null){
              user.updatePassword(passWord).catchError((e){
                print(e);
              });
              firestore
              .collection(userData)
              .document(user.uid)
              .updateData({userPassword: passWord});
            }
            
        if (message == successful) {
         
        }
      });
    } on PlatformException catch (e) {
      print(e);
    }
    return msg;
  }

  @override
  Future<String> reauthenticate({String userEmail, String currentPassword}) async {
 var user = FirebaseAuth.instance.currentUser();
 var cred = auth.reauthenticateWithEmailAndPassword(email:userEmail,password: currentPassword);
 return cred.toString();
  }
}
