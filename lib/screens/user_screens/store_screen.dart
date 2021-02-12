import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/services/storeDataBase.dart';
import 'package:flutter/material.dart';

import '../../constans.dart';
import 'product_info_screen.dart';
import 'search_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({
    Key key,
  }) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int tapBarIndex = 0;
  final _store = StoreDataBase();
  static List<ProductModel> products = [];
  int isFavorite = 0;
  var get;

  // bool isFave = false;
  // List<ProductModel> favList = [];
  // checkFavorite(id) async {
  //   await Provider.of<FavoriteItem>(context, listen: false).gatAllFavorite();
  //   favList =
  //       Provider.of<FavoriteItem>(context, listen: false).productFavoriteItems;
  //   for (var favitem in favList) {
  //     if (id == favitem.pId) {
  //       // setState(() {
  //       isFave = true;
  //       // });
  //       return;
  //     } else {
  //       // setState(() {
  //       isFave = false;
  //       // });
  //     }
  //     // setState(() {
  //     isFave;
  //     // });
  //     return;
  //   }
  //   print('isfav $isFave');
  //
  //   // return isFave;
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // get = Provider.of<FavoriteItem>(context, listen: false).gatAllFavorite();
  //
  //   // setState(() {
  //   //   isFavorite;
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IconButton(
                        icon: Icon(
                          Icons.search_rounded,
                          size: 30,
                          color: kBackgroundColor,
                        ),
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch());
                        }),
                  )
                ],
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(
                        color: Color(0xffF5E2C3),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                backgroundColor: Colors.black87.withOpacity(0.8),
                bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    physics: ScrollPhysics(),
                    // isScrollable: false,
                    // unselectedLabelColor: Colors.white,
                    indicatorWeight: 3,
                    indicatorColor: Color(0xffE5B669),
                    onTap: (value) {
                      setState(() {
                        tapBarIndex = value;
                      });
                    },
                    tabs: [
                      Text(
                        'All Art',
                        style: TextStyle(
                            color: tapBarIndex == 0
                                ? Color(0xffE5B669)
                                : Color(0xffF5E2C3),
                            fontSize: tapBarIndex == 0 ? 18 : null,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Art 2d',
                        style: TextStyle(
                            color: tapBarIndex == 1
                                ? Color(0xffE5B669)
                                : Color(0xffF5E2C3),
                            fontSize: tapBarIndex == 1 ? 18 : null,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Art 3d',
                        style: TextStyle(
                            color: tapBarIndex == 2
                                ? Color(0xffE5B669)
                                : Color(0xffF5E2C3),
                            fontSize: tapBarIndex == 2 ? 18 : null,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
              body: TabBarView(
                children: [
                  allArt(),
                  productView(kCatArt2d),
                  productView(kCatArt3d),
                ],
              )),
        ),

      ],
    );
  }

  Widget allArt() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.manageProduct(),
        builder: (context, snapshot) {
          print('snapshot  ' + snapshot.error.toString());
          if (snapshot.hasData) {
            List<ProductModel> listProduct = [];

            for (var doc in snapshot.data.docs) {
              var docData = doc.data();
              listProduct.add(ProductModel(
                  pId: doc.id,
                  pName: docData[kProductName],
                  pPrice: docData[kProductPrice],
                  pCategory: docData[kProductCategory],
                  pDescription: docData[kProductDescription],
                  pImageLocation: docData[kProductImageLocation]));
            }

            products = [...listProduct];
            // products.clear();

            print(listProduct);
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemCount: listProduct.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {});
                        Navigator.pushNamed(
                          context,
                          ProductInfo.id,
                          arguments: listProduct[index],
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.black54,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      listProduct[index].pImageLocation),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Opacity(
                                  opacity: 0.6,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.465,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            listProduct[index].pName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '\$ ${listProduct[index].pPrice}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
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
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black26,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  List<ProductModel> getProductByCatecory(String artCatrgory) {
    List<ProductModel> pro = [];
    for (var product in products) {
      if (product.pCategory == artCatrgory) {
        pro.add(product);
      }
    }
    return pro;
  }

  Widget productView(String artCatrgory) {
    List<ProductModel> products;

    products = getProductByCatecory(artCatrgory);
    print(products.toString());
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProductInfo.id,
                    arguments: products[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.black54,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(products[index].pImageLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: 0.6,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.465,
                            height: MediaQuery.of(context).size.height * 0.07,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    products[index].pName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$ ${products[index].pPrice}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
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
            ),
          );
        });
  }
}
