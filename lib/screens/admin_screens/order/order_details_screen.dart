import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/services/storeDataBase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatelessWidget {
  static String id = 'OrderDetailsScreen';

  StoreDataBase _storeDataBase = StoreDataBase();
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return LayoutBuilder(builder: (context, con) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final heightLocal = con.maxHeight;
      final widthLocal = con.maxWidth;
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Order Details',
            style: TextStyle(fontSize: widthLocal * 0.05),
          ),
          backgroundColor: kScandColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _storeDataBase.loadOrderDetails(args),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading Order Details ...'));
            } else {
              List<ProductModel> product = [];
              for (var doc in snapshot.data.docs) {
                product.add(ProductModel(
                  pName: doc.data()[kProductName],
                  pQuantity: doc.data()[kProductQuantity],
                  pCategory: doc.data()[kProductCategory],
                  pImageLocation: doc.data()[kProductImageLocation],
                  pPrice: doc.data()[kProductPrice],
                ));
              }
              return

                  ///
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, childAspectRatio: 1),
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        int pri = int.parse(product[index].pPrice) *
                            product[index].pQuantity;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black54,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: Stack(
                                children: [
                                  /// Image
                                  Positioned.fill(
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          product[index].pImageLocation),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Container(
                                        width: widthLocal,
                                        // MediaQuery.of(context).size.width,

                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ///name
                                              Text(
                                                product[index].pName,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: widthLocal * 0.05,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // SizedBox(height: 10),

                                              ///Category
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    ' ${product[index].pCategory}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            widthLocal * 0.04,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(),

                                                  ///Quantity
                                                  Text(
                                                    'Quantity :  ${product[index].pQuantity}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          widthLocal * 0.04,
                                                    ),
                                                  ),
                                                  SizedBox(),

                                                  ///Price
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Price :  ${product[index].pPrice} LE',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                              widthLocal * 0.04,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Total p :  $pri LE',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                              widthLocal * 0.04,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
            }
          },
        ),
      );
    });
  }
}

///----------------------------------------------------------------
// ///
// GridView.builder(
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 1, childAspectRatio: 1),
// itemCount: product.length,
// itemBuilder: (context, index) {
// int pri = int.parse(product[index].pPrice) *
// product[index].pQuantity;
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration(
// border: Border.all(
// width: 2,
// color: Colors.black54,
// ),
// borderRadius: BorderRadius.circular(20),
// ),
// child: ClipRRect(
// borderRadius: BorderRadius.all(Radius.circular(20)),
// child: Stack(
// children: [
// /// Image
// Positioned.fill(
// child: Image(
// fit: BoxFit.fill,
// image: NetworkImage(
// product[index].pImageLocation),
// ),
// ),
// Positioned(
// bottom: 0,
// child: Opacity(
// opacity: 0.6,
// child: Container(
// width: MediaQuery.of(context).size.width,
// // height:
// //     MediaQuery.of(context).size.height * 0.1,
// color: Colors.white,
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 30, vertical: 20),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: [
// ///name
// Text(
// product[index].pName,
// style: TextStyle(
// color: Colors.black,
// fontSize: 20,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(height: 10),
//
// ///Category
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceAround,
// children: [
// Text(
// ' ${product[index].pCategory}',
// style: TextStyle(
// color: Colors.black,
// fontSize: 17,
// fontWeight:
// FontWeight.bold),
// ),
// SizedBox(),
//
// ///Quantity
// Text(
// 'Quantity :  ${product[index].pQuantity}',
// style: TextStyle(
// color: Colors.black,
// fontSize: 17,
// fontWeight:
// FontWeight.bold),
// ),
// SizedBox(),
//
// ///Price
// Column(
// children: [
// Text(
// 'Price :  ${product[index].pPrice} LE',
// style: TextStyle(
// color: Colors.black,
// fontSize: 17,
// fontWeight:
// FontWeight.bold),
// ),
// Text(
// 'Total p :  $pri LE',
// style: TextStyle(
// color: Colors.black,
// fontSize: 17,
// fontWeight:
// FontWeight.bold),
// ),
// ],
// ),
// ],
// ),
// ],
// ),
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// );
// });
///------------------------------------------------------------------
