import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/model/order_model.dart';
import 'package:e_commerce/screens/admin_screens/order/order_details_screen.dart';
import 'package:e_commerce/services/storeDataBase.dart';
import 'package:e_commerce/widgets/show_massage_toast_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';

  StoreDataBase _dataBase = StoreDataBase();
  ShowMassageInUser massageInUser = ShowMassageInUser();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, con) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final heightLocal = con.maxHeight;
      final widthLocal = con.maxWidth;

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Orders',
            style: TextStyle(fontSize: widthLocal * 0.05),
          ),
          backgroundColor: kScandColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _dataBase.manageOrder(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OrderModel> orders = [];
              for (var doc in snapshot.data.docs) {
                var docData = doc.data();

                orders.add(
                  OrderModel(
                      docId: doc.id,
                      totalPrice: docData[kOrderTotalPrice],
                      address: docData[kOrderAddress],
                      fullName: docData[kOrderName],
                      phone: docData[kOrderPhone],
                      totalQuantity: docData[kProductQuantity]),
                );
              }
              return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, OrderDetailsScreen.id,
                            arguments: orders[index].docId);
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                                color: kBackgroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// name
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 40),
                                    child: Text(
                                      'Name :   ${orders[index].fullName}',
                                      style: TextStyle(
                                          fontSize: widthLocal * 0.05),
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // textDirection: TextDirection.ltr,
                                        children: [
                                          // SizedBox()
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Phone : ${orders[index].phone}',
                                              style: TextStyle(
                                                  fontSize: widthLocal * 0.04),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Address : ${orders[index].address}',
                                              style: TextStyle(
                                                  fontSize: widthLocal * 0.04),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Total Price:${orders[index].totalPrice}',
                                              style: TextStyle(
                                                  fontSize: widthLocal * 0.04),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Total Quantity:${orders[index].totalQuantity}',
                                              style: TextStyle(
                                                  fontSize: widthLocal * 0.04),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        FlatButton(
                                            onPressed: () {
                                              sendOrderByWhatsApp(
                                                  phoneNumber:
                                                      orders[index].phone,
                                                  order: orders[index]);
                                            },
                                            color: kMainColor,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: widthLocal * 0.01,
                                                  vertical: heightLocal * 0.01),
                                              child: Text(
                                                'Confirm ',
                                                style: TextStyle(
                                                    fontSize:
                                                        widthLocal * 0.04),
                                              ),
                                            )),
                                        FlatButton(
                                            color: Colors.red.shade200,
                                            onPressed: () {
                                              _dataBase.deleteOrder(
                                                  orders[index].docId);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: widthLocal * 0.01,
                                                  vertical: heightLocal * 0.01),
                                              child: Text(
                                                'Delete ',
                                                style: TextStyle(
                                                    fontSize:
                                                        widthLocal * 0.04),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return null;
          },
        ),
      );
    });
  }

  sendOrderByWhatsApp(
      {@required OrderModel order, @required phoneNumber}) async {
    String url;
    var orderMassage;

    var ms1 =
        ' Hi ${order.fullName}   You have  ordered some products, \n quantities : ${order.totalQuantity}, \n  Total price : ${order.totalPrice}';
    var ms2 =
        '\nYou will be contacted shortly to collect the item\n\nThank you for ordering the product from our app ';
    var totalMassage = ms1 + ms2;
    print(totalMassage);
    url = 'whatsapp://send?phone=$phoneNumber&text=$totalMassage';
    await canLaunch(url)
        ? launch(url)
        : massageInUser.show_toast("Can't open whatsapp", 5);
    //
  }
}
