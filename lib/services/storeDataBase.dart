import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoreDataBase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://e-commerce-buyit.appspot.com');

  addProduct(ProductModel productModel) {
    _firebaseFirestore.collection(kProductCollection).add({
      kProductName: productModel.pName,
      kProductPrice: productModel.pPrice,
      kProductDescription: productModel.pDescription,
      kProductCategory: productModel.pCategory,
      kProductImageLocation: productModel.pImageLocation,
    });
  }

  Stream<QuerySnapshot> manageProduct() {
    return _firebaseFirestore.collection(kProductCollection).snapshots();
  }

  deleteProduct(
    docId,
  ) async {
    await _firebaseFirestore.collection(kProductCollection).doc(docId).delete();
  }

  editProduct(data, docId) async {
    _firebaseFirestore.collection(kProductCollection).doc(docId).update(data);
  }

  storeOrder(data, List<ProductModel> products) {
    var docRef = _firebaseFirestore.collection(kOrders).doc();
    docRef.set(data);

    for (var product in products) {
      docRef.collection(kOrderDetails).doc().set({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductQuantity: product.pQuantity,
        kProductImageLocation: product.pImageLocation,
        kProductCategory: product.pCategory,
      });
    }
  }

  Stream<QuerySnapshot> manageOrder() {
    return _firebaseFirestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(docId) {
    return _firebaseFirestore
        .collection(kOrders)
        .doc(docId)
        .collection(kOrderDetails)
        .snapshots();
  }

  deleteOrder(docId) async {
    await _firebaseFirestore
        .collection(kOrders)
        .doc(docId)
        .collection(kOrderDetails)
        .doc(docId)
        .delete();
    await _firebaseFirestore.collection(kOrders).doc(docId).delete();
  }
}
