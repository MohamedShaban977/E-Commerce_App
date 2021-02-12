import 'package:e_commerce/model/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constans.dart';

class FavoriteDatabase {
  FavoriteDatabase._();
  static final FavoriteDatabase db = FavoriteDatabase._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'FavoriteProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
CREATE TABLE $kFavoriteProduct (
$kProductName TEXT NOT NULL,
$kProductPrice TEXT NOT NULL,
$kProductImageLocation TEXT NOT NULL,
$kProductId TEXT NOT NULL,
$kProductCategory TEXT NOT NULL,
$kProductDescription TEXT NOT NULL,
$kProductQuantity INTEGER NOT NULL,
$kIsFavorite BOOLEAN NOT NULL)
''');
    });
  }

  inser(ProductModel productModel) async {
    var dbClient = await database;
    await dbClient.insert(kFavoriteProduct, productModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ProductModel>> getAllFavoriteProduct() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(kFavoriteProduct);
    List<ProductModel> listFavorite =
        maps.map((e) => ProductModel.fromJson(e)).toList();
    // print("getAll  " + listFavorite.reversed.toString());

    return listFavorite;
  }

  deleteData(id) async {
    var dbClient = await database;
    await dbClient
        .delete(kFavoriteProduct, where: '$kProductId =?', whereArgs: [id]);
  }

  // updateCart(ProductModel productModel) async {
  //   var dbClient = await database;
  //   await dbClient.update(kFavoriteProduct, productModel.toJson(),
  //       where: '$kProductId =?', whereArgs: [productModel.pId]);
  // }

  Future<ProductModel> getCart(id) async {
    var dbClient = await database;
    List<Map> maps = await dbClient
        .query(kFavoriteProduct, where: '$kProductId =?', whereArgs: [id]);
    if (maps.length > 0) {
      return ProductModel.fromJson(maps.first);
    } else {
      return null;
    }
  }
}
