import 'package:e_commerce/constans.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {
  CartDatabase._();
  static final CartDatabase db = CartDatabase._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
CREATE TABLE $kCartProduct (
$kProductName TEXT NOT NULL,
$kProductPrice TEXT NOT NULL,
$kProductImageLocation TEXT NOT NULL,
$kProductQuantity INTEGER NOT NULL,
$kProductCategory TEXT NOT NULL,
$kProductDescription TEXT NOT NULL,
$kIsFavorite BOOLEAN,
$kProductId TEXT NOT NULL)
''');
    });
  }

  inser(ProductModel cartModel) async {
    var dbClient = await database;
    await dbClient.insert(kCartProduct, cartModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ProductModel>> getAllCartProduct() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(kCartProduct);
    List<ProductModel> listCart = maps.map((e) => ProductModel.fromJson(e)).toList();
    return listCart;
  }

  deleteData(id) async {
    var dbClient = await database;
    await dbClient
        .delete(kCartProduct, where: '$kProductId =?', whereArgs: [id]);
  }

  // updateCart(CartModel cartModel) async {
  //   var dbClient = await database;
  //   await dbClient.update(kCartProduct, cartModel.toJson(),
  //       where: '$kCartId =?', whereArgs: [cartModel.id]);
  // }

  // Future<CartModel> getCart(id) async {
  //   var dbClient = await database;
  //   List<Map> maps = await dbClient
  //       .query(kCartProduct, where: '$kCartId =?', whereArgs: [id]);
  //   if (maps.length > 0) {
  //     return CartModel.fromJson(maps.first);
  //   } else {
  //     return null;
  //   }
  // }
}
