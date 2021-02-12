import 'package:e_commerce/model/cart_sql_Model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  List<ProductModel> cartList = [];
  int quantity = 1;

  addProductToCart(ProductModel cartModel) async {
    var db = CartDatabase.db;
    await db.inser(cartModel);
    cartList.add(cartModel);

    notifyListeners();
  }

  subtract() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  add() {
    quantity++;
    notifyListeners();
  }

  getTotalPrice() {
    var price = 0;
    for (var product in cartList) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }

  getAllQuantity() {
    var quantity = 0;
    for (var proQuantity in cartList) {
      quantity += proQuantity.pQuantity;
    }
    return quantity;
  }

  Future<List<ProductModel>> gatAllCArt() async {
    var db = CartDatabase.db;
    cartList = await db.getAllCartProduct();
    print('res $cartList');
    notifyListeners();
    return cartList;
  }

  deleteProductToCart(id) async {
    var db = CartDatabase.db;
    cartList = await db.deleteData(id);

    notifyListeners();
  }
}
