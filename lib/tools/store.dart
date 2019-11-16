import 'package:flutter/material.dart';

class Store{
  String itemID;
  String itemName;
  String itemDescription;
  double itemPrice;
  String itemImage;
  double itemRating;
  IconData icon;
  bool isFavorited;
  //String itemSubname;

  Store.items({
     this.itemID,
    this.itemName,
    this.itemDescription,
     this.itemPrice,
     this.itemImage,
    this.itemRating,
    this.icon,
   this.isFavorited = false,
    //this.itemSubname,

  });
}
Iterable<Store> getItem;
List<Store> storeItems = [
Store.items(
  itemName: "Lif isnhar",
  itemDescription: "A walk in the park",
    itemPrice: 230.00,
    itemImage: "",
    itemRating: 0.0,
    isFavorited: false,
),
Store.items(
  itemName: "Lif isnhar",
  itemDescription: "A walk in the park",
    itemPrice: 230.00,
    itemImage: "",
    itemRating: 0.0,
    isFavorited: false,
),
Store.items(
  itemName: "Lif isnhar",
  itemDescription: "A walk in the park",
    itemPrice: 230.00,
    itemImage: "",
    itemRating: 0.0,
    isFavorited: false,
),
Store.items(
  itemName: "Lif isnhar",
  itemDescription: "A walk in the park",
    itemPrice: 230.00,
    itemImage: "",
    itemRating: 0.0,
    isFavorited: false,
)


];
