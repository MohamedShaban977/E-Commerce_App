import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/provider/favorite_itme.dart';
import 'package:e_commerce/services/storage.dart';
import 'package:e_commerce/widgets/cosume_buttom.dart';
import 'package:e_commerce/widgets/show_massage_toast_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  ShowMassageInUser massageInUser = ShowMassageInUser();
  bool exist = false;
  bool isFave = false;
  ProductModel arg;
  var favoriteItem;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // gatFave();
  // }
  //
  // Future gatFave() async {
  //   await Provider.of<FavoriteItem>(context, listen: false).gatAllFavorite();
  //
  //   // favoriteItem =
  //   //     Provider.of<FavoriteItem>(context, listen: false).productFavoriteItems;
  //   // // isChacked();
  // }

  @override
  Widget build(BuildContext context) {
    favoriteItem = Provider.of<FavoriteItem>(context, listen: false);

    arg = ModalRoute.of(context).settings.arguments;
    isChacked();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: null,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            /// pImageLocation
                            Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.elliptical(50, 50)),
                                  child: Image(
                                    image: NetworkImage(arg.pImageLocation),
                                    fit: BoxFit.cover,
                                  )),
                            ),

                            /// all Arg
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular()
                                ),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenl,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    /// Name
                                    Text(
                                      arg.pName,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),

                                    /// Price & Category
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Category :  ${arg.pCategory}',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Price : ${arg.pPrice}  LE',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),

                                    /// pDescription
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        // height: MediaQuery.of(context).size.height * 0.09,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.black12
                                                .withOpacity(0.05)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            arg.pDescription,
                                            textAlign: TextAlign.start,
                                            textDirection:
                                                arg.pDescription.contains('ا')
                                                    ? TextDirection.rtl
                                                    : null,
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// add &&sub Quantity
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ///Add
                              ClipOval(
                                child: Material(
                                  color: Colors.black87,
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<CartItem>(context,
                                              listen: false)
                                          .add();
                                      print(Provider.of<CartItem>(context,
                                              listen: false)
                                          .quantity
                                          .toString());
                                    },
                                    child: SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xffE5B669),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),

                              /// Text Quantity
                              Text(
                                (Provider.of<CartItem>(
                                  context,
                                ).quantity.toString()),
                                style: TextStyle(fontSize: 40),
                              ),
                              SizedBox(width: 10),

                              /// Subtract
                              ClipOval(
                                child: Material(
                                  color: Colors.black87,
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<CartItem>(context,
                                              listen: false)
                                          .subtract();
                                      // print(Provider.of<CartItem>(context,
                                      //         listen: false)
                                      //     .quantity
                                      //     .toString());
                                      // print(arg.pQuantity);
                                    },
                                    child: SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: Icon(
                                        Icons.remove,
                                        color: Color(0xffE5B669),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// Add To Cart & Add To Favorite
                          Row(
                            children: [
                              /// Add To Favorite
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                child: Builder(builder: (context) {
                                  return CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color:
                                            exist ? Colors.red : Colors.black45,
                                      ),
                                      onPressed: () async {
                                        await addItemToFav(context, arg);

                                        setState(() {});
                                        // isChacked();
                                      },
                                    ),
                                  );
                                }),
                              ),

                              /// Add To Cart
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Builder(
                                    builder: (context) => ButtonCustomWidget(
                                      textbutton: 'Add Cart',
                                      onPressed: () {
                                        addToCart(context);
                                      },
                                      backgroundColor:
                                          Colors.black87.withOpacity(0.8),
                                      textColor: Color(0xffE5B669),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  ///arrow_back
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, HomeScreen.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                      ),
                    ),
                  ),

                  /// Download Image
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Builder(
                      builder: (context) => IconButton(
                          icon: Icon(
                            Icons.file_download,
                            size: 40,
                            color: Colors.black45,
                          ),
                          onPressed: () async {
                            await Provider.of<StorageImage>(context,
                                    listen: false)
                                .save(arg.pImageLocation);
                            massageInUser.showSnackBar(
                                context, "Downloaded Is Don", 1);
                          }),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  void addToCart(BuildContext context) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    arg.pQuantity = cartItem.quantity;
    bool existadd = false;
    List<ProductModel> productInCart = cartItem.cartList;
    for (var Cart in productInCart) {
      if (Cart.pId == arg.pId) {
        existadd = true;
      }
    }
    if (existadd) {
      massageInUser.showSnackBar(context, 'you\'ve added this item before', 1);
    } else {
      cartItem.addProductToCart(
        ProductModel(
          pName: arg.pName,
          pImageLocation: arg.pImageLocation,
          pDescription: arg.pDescription,
          pCategory: arg.pCategory,
          pPrice: arg.pPrice,
          pId: arg.pId,
          pQuantity: cartItem.quantity,
        ),
      );
      // cartItem.gatAllCArt();
      massageInUser.showSnackBar(context, 'Add To Cart', 1);

      Provider.of<CartItem>(context, listen: false).quantity = 1;
    }
  }

  void addItemToFav(BuildContext context, ProductModel arg) async {
    // final favoriteItem = Provider.of<FavoriteItem>(context, listen: false);
    await favoriteItem.gatAllFavorite();
    List<ProductModel> existFavProduct = favoriteItem.productFavoriteItems;
    if (existFavProduct.length != 0) {
      for (var i in existFavProduct) {
        if (arg.pId == i.pId) {
          setState(() {
            exist = true;
          });
          // await isChacked();
        }
      }
      if (exist) {
        // exist =true;
        massageInUser.showSnackBar(
            context, 'you\'ve added this item before', 1);
      } else {
        favoriteItem.addProductToFavorite(ProductModel(
          pId: arg.pId,
          pPrice: arg.pPrice,
          pName: arg.pName,
          pImageLocation: arg.pImageLocation,
          pCategory: arg.pCategory,
          isFavorite: 1,
          pDescription: arg.pDescription,
          pQuantity: 1,
        ));
        setState(() {
          exist = true;
        });
        print("exist $exist");

        massageInUser.showSnackBar(context, 'Add To Favorite', 1);
      }
      return;
    } else {
      favoriteItem.addProductToFavorite(ProductModel(
        pId: arg.pId,
        pPrice: arg.pPrice,
        pName: arg.pName,
        pImageLocation: arg.pImageLocation,
        pCategory: arg.pCategory,
        isFavorite: 1,
        pDescription: arg.pDescription,
        pQuantity: 1,
      ));
      setState(() {
        exist = true;
      });
      print("exist $exist");

      massageInUser.showSnackBar(context, 'Add To Favorite', 1);
    }
  }

  isChacked() async {
    favoriteItem.gatAllFavorite();

    var listFave = favoriteItem.productFavoriteItems;

    print('listFave ${listFave.length}');
    for (var fave in listFave) {
      if (arg.pId == fave.pId) {
        setState(() {
          exist = true;
        });

        print(exist);
      }
    }
    // setState(() {});
    return exist;
  }
}
