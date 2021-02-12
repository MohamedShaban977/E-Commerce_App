import 'package:e_commerce/model/favorite_sql_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class FavoriteItem extends ChangeNotifier {
  List<ProductModel> productFavoriteItems = [];
  bool isF = false;

  void addItemToFav(BuildContext context, ProductModel arg) async {
    await gatAllFavorite();
    List<ProductModel> existFavProduct = productFavoriteItems;
    print('esit fav product' + existFavProduct.length.toString());
    if (existFavProduct.length != 0) {
      for (var i in existFavProduct) {
        if (arg.pId == i.pId) {
          isF = true;
          print('add before ${i.pName}');
        }
      }
      if (isF) {
        print('add1${isF}');
      } else {
        print('add2');
        addProductToFavorite(ProductModel(
          pId: arg.pId,
          pPrice: arg.pPrice,
          pName: arg.pName,
          pImageLocation: arg.pImageLocation,
          pCategory: arg.pCategory,
          pDescription: arg.pDescription,
          pQuantity: 1,
          isFavorite: 1,
        ));
      }
    } else {
      addProductToFavorite(ProductModel(
        pId: arg.pId,
        pPrice: arg.pPrice,
        pName: arg.pName,
        pImageLocation: arg.pImageLocation,
        pCategory: arg.pCategory,
        pDescription: arg.pDescription,
        pQuantity: 1,
        isFavorite: 1,
      ));
    }
    notifyListeners();
  }

  addProductToFavorite(ProductModel productModel) async {
    var db = FavoriteDatabase.db;
    await db.inser(productModel);
    notifyListeners();
  }

  Future<List<ProductModel>> gatAllFavorite() async {
    var db = FavoriteDatabase.db;
    productFavoriteItems = await db.getAllFavoriteProduct();
    print('resFavorite $productFavoriteItems');
    notifyListeners();
    return productFavoriteItems;
  }

  deleteProductToFavorite(id) async {
    var db = FavoriteDatabase.db;
    productFavoriteItems = await db.deleteData(id);

    print('productFavoriteItems delete' + ' $productFavoriteItems');

    notifyListeners();
  }
}
