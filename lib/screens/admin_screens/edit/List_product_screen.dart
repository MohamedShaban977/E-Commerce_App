import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'file:///F:/Android/FlutterProjects/e_commerce/lib/screens/admin_screens/edit/edit_product_screen.dart';
import 'package:e_commerce/services/storage.dart';
import 'package:e_commerce/services/storeDataBase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListProductScreen extends StatelessWidget {
  static String id = 'ListProductScreen';

  final StoreDataBase _store = StoreDataBase();
  final StorageImage _manageImage = StorageImage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff325F6D),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'List Product',
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontFamily: 'pacifico'),
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.manageProduct(),
          builder: (context, snapshot) {
            var sData = snapshot.data;
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
                  pImageLocation: docData[kProductImageLocation],
                ));
              }

              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.7),
                  itemCount: listProduct.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onLongPressStart: (details) {
                          double dx = details.globalPosition.dx;
                          double dy = details.globalPosition.dy;
                          double dx2 = MediaQuery.of(context).size.width - dx;
                          double dy2 = MediaQuery.of(context).size.height - dy;
                          showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                              items: [
                                MyPopupMenuItem(
                                  child: Text('Edit Product'),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, EditProductScreen.id,
                                        arguments: listProduct[index]);
                                  },
                                ),
                                MyPopupMenuItem(
                                  onTap: () {
                                    print('delete Product');
                                    _store
                                        .deleteProduct(listProduct[index].pId);

                                    _manageImage.deleteImage(
                                        listProduct[index].pImageLocation);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete Product'),
                                ),
                              ]);
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                Positioned(
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black54,
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
          }),
    );
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onTap;

  MyPopupMenuItem({@required this.child, @required this.onTap})
      : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    // TODO: implement createState
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onTap();
  }
}
