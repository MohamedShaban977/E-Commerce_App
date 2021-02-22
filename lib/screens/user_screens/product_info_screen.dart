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

  @override
  Widget build(BuildContext context) {
    favoriteItem = Provider.of<FavoriteItem>(context, listen: false);

    arg = ModalRoute.of(context).settings.arguments;
    isChacked();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (context, con) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          final heightLocal = con.maxHeight;
          final widthLocal = con.maxWidth;
          return StreamBuilder(
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
                                height: height * 0.5,
                                width: width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.elliptical(
                                            widthLocal * 0.05,
                                            widthLocal * 0.05)),
                                    child: Image(
                                      image: NetworkImage(arg.pImageLocation),
                                      fit: BoxFit.fill,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      /// Name
                                      Text(
                                        arg.pName,
                                        style: TextStyle(
                                            fontSize: widthLocal * 0.04,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: heightLocal * 0.01),

                                      /// Price & Category
                                      Text(
                                        'Category :  ${arg.pCategory}',
                                        style: TextStyle(
                                            fontSize: widthLocal * 0.04,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: heightLocal * 0.01),

                                      Text(
                                        'Price : ${arg.pPrice}  LE',
                                        style: TextStyle(
                                            fontSize: widthLocal * 0.04,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: heightLocal * 0.01),

                                      /// pDescription
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: widthLocal * 0.03,
                                            vertical: heightLocal * 0.02),
                                        child: Container(
                                          // height: MediaQuery.of(context).size.height * 0.09,
                                          width: widthLocal,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black12
                                                  .withOpacity(0.05)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: widthLocal * 0.02),
                                            child: Text(
                                              arg.pDescription,
                                              textAlign: TextAlign.start,
                                              textDirection:
                                                  arg.pDescription.contains('ا')
                                                      ? TextDirection.rtl
                                                      : null,
                                              style: TextStyle(
                                                fontSize: widthLocal * 0.04,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: heightLocal * 0.01),
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
                                        child: Icon(
                                          Icons.add,
                                          color: Color(0xffE5B669),
                                          size: widthLocal * 0.06,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: widthLocal * 0.04),

                                /// Text Quantity
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    (Provider.of<CartItem>(
                                      context,
                                    ).quantity.toString()),
                                    style:
                                        TextStyle(fontSize: widthLocal * 0.06),
                                  ),
                                ),
                                SizedBox(width: widthLocal * 0.04),

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
                                        child: Icon(
                                          Icons.remove,
                                          color: Color(0xffE5B669),
                                          size: widthLocal * 0.06,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            /// Add To Cart & Add To Favorite
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widthLocal * 0.03),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  /// Add To Favorite
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Builder(builder: (context) {
                                      return CircleAvatar(
                                        backgroundColor: Colors.black12,
                                        // radius: widthLocal * 0.05,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                            color: exist
                                                ? Colors.red
                                                : Colors.black45,
                                            size: widthLocal * 0.05,
                                          ),
                                          onPressed: () async {
                                            await addItemToFav(context, arg);

                                            setState(() {});
                                            // isChacked();
                                          },
                                          // iconSize: widthLocal * 0.05,
                                        ),
                                      );
                                    }),
                                  ),
                                  SizedBox(width: widthLocal * 0.02),

                                  /// Add To Cart
                                  Expanded(
                                    child: Builder(
                                      builder: (context) => ButtonCustomWidget(
                                        textbutton: 'Add Cart',
                                        fontSize: widthLocal * 0.04,
                                        onPressed: () {
                                          addToCart(context);
                                        },
                                        backgroundColor:
                                            Colors.black87.withOpacity(0.8),
                                        textColor: Color(0xffE5B669),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                      right: widthLocal * 0.04,
                      top: heightLocal * 0.04,
                      child: Builder(
                        builder: (context) => IconButton(
                            icon: Icon(
                              Icons.arrow_circle_down,
                              size: widthLocal * 0.1,
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
              });
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
