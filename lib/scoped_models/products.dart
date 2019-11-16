import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:store/tools/appData.dart';
import 'package:store/tools/app_methods.dart';
import 'package:store/tools/firebase_methods.dart';
import 'package:store/tools/store.dart';


class ProductsModel extends Model{
  AppMethods appMethods = FirebaseMethods();
List<Store> _store = [];

List<Store> get store{
  return List.from(_store);
}

void addProduct(Store store){
  _store.add(store);
}
void updateProduct(int index, Store store){
  _store[index] = store;
}
void deleteProduct(int index){
 _store.removeAt(index); 
}

 void toggelFavourite(DocumentSnapshot document ,int index){
     List productImage =document[productImages] as List;
    final bool isCurrentFavorite = storeItems[index].isFavorited;
    final bool newFavoriteStatus = !isCurrentFavorite;
    final Store updatedProduct = Store.items(
      itemName: document[productTitle],
      itemDescription: document[productDescription],
      itemPrice: document[productPrice],
      itemImage: document[productImage[0]],
      itemRating: storeItems[index].itemRating,
      isFavorited: newFavoriteStatus
    );
    storeItems[index] = updatedProduct;

  }
Future productList(DocumentSnapshot snapshot){
  var _data = appMethods.getProducts();
  return _data;
}
}