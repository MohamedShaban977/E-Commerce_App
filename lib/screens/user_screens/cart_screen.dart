import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:e_commerce/services/storeDataBase.dart';
import 'package:e_commerce/widgets/cosume_buttom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constans.dart';
import 'product_info_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _name, _phone, _address;
  var totalPrice;
  var totalQuantity;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, con) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final heightLocal = con.maxHeight;
      final widthLocal = con.maxWidth;
      return Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Icon(
                  FontAwesomeIcons.store,
                  color: kMainColor,
                  size: widthLocal * 0.04,
                ),
              ),
            ],
            title: Text(
              'My Cart',
              style: TextStyle(fontSize: widthLocal * 0.04, color: kMainColor),
            ),
            backgroundColor: kScandColor,
            // elevation: 0,
          ),
          body: LayoutBuilder(
            builder: (context, con) => FutureBuilder<List<ProductModel>>(
                future:
                    Provider.of<CartItem>(context, listen: false).gatAllCArt(),
                builder: (context, snapshot) {
                  List<ProductModel> listCart = snapshot.data;
                  totalPrice = Provider.of<CartItem>(context).getTotalPrice();
                  totalQuantity =
                      Provider.of<CartItem>(context).getAllQuantity();
                  if (snapshot.hasData) {
                    if (listCart == null ||
                        listCart.isEmpty ||
                        listCart == []) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage('images/empty-cart.png')),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: listCart.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: widthLocal,
                                          // height: height * 0.1,
                                          decoration: BoxDecoration(
                                            color: kMainColor.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image(
                                                    image: NetworkImage(
                                                        listCart[index]
                                                            .pImageLocation),
                                                    fit: BoxFit.fill,
                                                    height: heightLocal * 0.25,
                                                    width: widthLocal * 0.25,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: widthLocal * 0.4,
                                                      child: Text(
                                                        listCart[index].pName,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              widthLocal * 0.04,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Quantity : ' +
                                                          listCart[index]
                                                              .pQuantity
                                                              .toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            widthLocal * 0.04,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Price : ' +
                                                          listCart[index]
                                                              .pPrice
                                                              .toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            widthLocal * 0.04,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // SizedBox(
                                              //   width: width * 0.15,

                                              // ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      Provider.of<CartItem>(
                                                              context,
                                                              listen: false)
                                                          .deleteProductToCart(
                                                              listCart[index]
                                                                  .pId);
                                                      setState(() {});

                                                      Navigator.pushNamed(
                                                          context,
                                                          ProductInfo.id,
                                                          arguments:
                                                              listCart[index]);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.mode_edit,
                                                        color: Colors.black87
                                                            .withOpacity(0.7),
                                                        size: widthLocal * 0.04,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          heightLocal * 0.07),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Provider.of<CartItem>(
                                                              context,
                                                              listen: false)
                                                          .deleteProductToCart(
                                                              listCart[index]
                                                                  .pId);
                                                      setState(() {});
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                        size: widthLocal * 0.04,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widthLocal * 0.04,
                                vertical: heightLocal * 0.01),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  // 'yu',
                                  'Total Price : $totalPrice  LE',
                                  style: TextStyle(fontSize: widthLocal * 0.04),
                                ),
                                Builder(
                                  builder: (context) => ButtonCustomWidget(
                                      textbutton: 'Order'.toUpperCase(),
                                      fontSize: widthLocal * 0.04,
                                      onPressed: () async {
                                        orderCart(context, listCart);
                                      },
                                      backgroundColor: kScandColor,
                                      textColor: kMainColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ));
    });
  }

  void orderCart(context, cartItem) {
    final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
    AlertDialog alert = AlertDialog(
      backgroundColor: kBackgroundColor,
      title: Text("Enter contact information"),
      titleTextStyle: TextStyle(color: kScandColor, fontSize: 20),
      // contentTextStyle: TextStyle(color: Colors.white, fontSize: 17),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Name is Empty';
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your Full Name',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                // initialValue: '+20',
                onChanged: (value) {
                  _phone = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Phone is Empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your Phone',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Address is Empty';
                  }
                  return null;
                },
                onChanged: (value) {
                  _address = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your Address',
                ),
              ),
              SizedBox(height: 20),
              ButtonCustomWidget(
                  textbutton: "OK",
                  onPressed: () async {
                    if (_globalKey.currentState.validate()) {
                      try {
                        StoreDataBase _storeDB = StoreDataBase();
                        await _storeDB.storeOrder({
                          kOrderName: _name,
                          kOrderPhone:
                              _phone.startsWith("+2") ? _phone : '+2' + _phone,
                          kOrderAddress: _address,
                          kOrderTotalPrice: totalPrice,
                          kProductQuantity: totalQuantity,
                        }, cartItem);
                        Navigator.pop(context);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Order Successfully'),
                        ));
                      } catch (ex) {
                        print(ex.toString());
                      }
                    }
                  },
                  backgroundColor: kScandColor,
                  textColor: kMainColor),
            ],
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  sendOrderByWhatsApp(
      {@required List<ProductModel> products, @required massage}) async {
    String phoneNumber = '+201150616852';
    String url;
    var orderMassage;
    var listMassage = [];

    int num = 1;
    for (var product in products) {
      orderMassage =
          ' \nP $num  :  \n Product Name : ${product.pName} \n  Product Price : ${product.pPrice} \$  \n  Quantity : ${product.pQuantity}  \n ';
      num += num;
      listMassage.add(orderMassage);
    }
    var clenMassage = listMassage.toString().replaceRange(0, 1, '');
    clenMassage = clenMassage.replaceRange(
        clenMassage.length - 1, clenMassage.length, '');
    var ms1 = 'I need to order the following products : \n';
    var ms2 =
        '\nYou will be contacted shortly to collect the item\n\nThank you for ordering the product from our app ';
    var totalMassage = ms1 + clenMassage + massage + ms2;
    print(clenMassage);
    url = 'whatsapp://send?phone=$phoneNumber&text=$totalMassage';
    await canLaunch(url) ? launch(url) : print("Can't open whatsapp");
    //
  }
}
