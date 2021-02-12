import '../constans.dart';

class ProductModel {
  String pName, pPrice, pDescription, pCategory, pImageLocation, pId;
  int pQuantity;
  int isFavorite;

  ProductModel(
      {this.pId,
      this.pName,
      this.pPrice,
      this.pDescription,
      this.pCategory,
      this.pImageLocation,
      this.pQuantity,
      this.isFavorite});

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    pName = map[kProductName];
    pImageLocation = map[kProductImageLocation];
    pPrice = map[kProductPrice];
    pId = map[kProductId];
    isFavorite = map[kIsFavorite];
    pCategory = map[kProductCategory];
    pDescription = map[kProductDescription];
    pQuantity = map[kProductQuantity];
  }
  toJson() {
    return {
      kProductName: pName,
      kProductPrice: pPrice,
      kProductImageLocation: pImageLocation,
      kProductId: pId,
      kProductCategory: pCategory,
      kProductDescription: pDescription,
      kProductQuantity: pQuantity,
      kIsFavorite: isFavorite,
    };
  }
}
