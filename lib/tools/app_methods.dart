 import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
 abstract class AppMethods{
   Future<String> loginUser({String email, String password});
  Future<String> createUser({String fullname, String phone, String email, String password});
  Future <bool> logOutUser();

  Future<DocumentSnapshot> getUserInfo(String userid);
  Future<String> addNewProduct({Map newProduct});
  Future<String> addNewCategory({Map newCategory});
  Future<List<String>> uploadCatIcon({List<File> iconAdd,String docID});
  Future<List<String>> uploadProductImages({List< File> imageList,String docID});
  
  Future <bool> updateCategoryIcon({String docId,List<String> data});
  Future <bool> updateProductImages({
    String docID,
    List<String> data,
  });
 Future getProducts();

  Future deleteProduct(String docID);
  Future deleteFavorite(String docID);
  Future deleteFromCart(String docID);
  Future <DocumentSnapshot> getProductID(String prdID);

  Future getUsers();

   searchByName(String searchField);
  Future<String> userOrder({String userid,String prodtTitle,String prodtVariation,String prodtPrice,String itemQty,String date});
  getOrderHistorybyId(String userID);
  getCollectionLength(int number);
   Future<String> userCart({String userid,String prodtTitle,String prodtVariation,String prodtPrice,String itemQty, List prodtImages});
     Future getCurrentUser(String userid);
     Future getCart();
     Future<String> getFavorites( {String userid,String isFavorited,
     String prodtTitle,
     String prodtCat,
      String prodtVariation,
       String prodtPrice,
       String prodtDesc,
        String itemQty, 
        String itemRating,
        List prodtImages});

         Stream<QuerySnapshot> search();
         Future getFav(String userid);
         Future getUserCart(String userid);
         Future<int> getCartCount();
         Future loadProducts(productCategory);
         Future getCategory();
         Future<bool> changePassword({String eMail,String currentpassword,String passWord});
         Future reauthenticate({
           String userEmail,
           String currentPassword
         });
  }
 
 

 

  