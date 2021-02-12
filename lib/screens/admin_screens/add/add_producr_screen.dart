import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/provider/model_hud.dart';
import 'package:e_commerce/services/storage.dart';
import 'package:e_commerce/services/storeDataBase.dart';
import 'package:e_commerce/widgets/costum_text_form.dart';
import 'package:e_commerce/widgets/cosume_buttom.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String _name, _price, _description, _category;

  final StoreDataBase _store = StoreDataBase();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff325F6D),
      // backgroundColor: Color(0xff325F6D),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              Column(
                children: [
                  /// Text Add Product
                  Text(
                    'Add Product',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontFamily: 'pacifico',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),

                  /// TextForm Product Name
                  CustomTextFormWidget(
                    hint: 'Product Name',
                    label: null,
                    obscureText: false,
                    onChanged: (value) {
                      _name = value;
                    },
                    backgroundColor: Colors.black12,
                    textColor: Color(0xffC34072),
                  ),
                  SizedBox(height: 20),

                  /// TextForm Product Price
                  CustomTextFormWidget(
                    hint: 'Product Price',
                    label: null,
                    obscureText: false,
                    onChanged: (value) {
                      _price = value;
                    },
                    backgroundColor: Colors.black12,
                    textColor: Color(0xffC34072),
                  ),
                  SizedBox(height: 20),

                  /// TextForm Product Description
                  CustomTextFormWidget(
                    hint: 'Product Description',
                    label: null,
                    obscureText: false,
                    onChanged: (value) {
                      _description = value;
                    },
                    backgroundColor: Colors.black12,
                    textColor: Color(0xffC34072),
                  ),
                  SizedBox(height: 20),

                  /// TextForm Product Category
                  CustomTextFormWidget(
                    hint: 'Product Category',
                    label: null,
                    obscureText: false,
                    onChanged: (value) {
                      _category = value;
                    },
                    backgroundColor: Colors.black12,
                    textColor: Color(0xffC34072),
                  ),
                  SizedBox(height: 20),

                  Column(
                    children: [
                      /// Choose pictures
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (Provider.of<StorageImage>(context,
                                          listen: false)
                                      .fileImage !=
                                  null) {
                                Provider.of<StorageImage>(context, listen: false)
                                    .openImage(context, null);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Please Chose image',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    timeInSecForIosWeb: 5,
                                    fontSize: 18);
                              }
                            },

                            /// View Product Image
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Provider.of<StorageImage>(context)
                                          .fileImage ==
                                      null
                                  ?

                                  ///  'Add Product Image '
                                  Container(
                                      width: 200,
                                      height: 150,
                                      color: Colors.black38,
                                      child: Center(
                                          child: Text(
                                        'Add Product Image ',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      )),
                                    )
                                  : Stack(
                                      children: [
                                        Image(
                                          image: FileImage(
                                              Provider.of<StorageImage>(context)
                                                  .fileImage),
                                          fit: BoxFit.cover,
                                          width: 200,
                                          height: 150,
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.visibility_sharp,
                                                size: 25,
                                                color: Colors.black45,
                                              ),
                                            )),
                                      ],
                                    ),
                            ),
                          ),
                          // SizedBox(width: 10),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xffC34072),
                            child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 25,
                                ),
                                onPressed: () {
                                  Provider.of<StorageImage>(context,
                                          listen: false)
                                      .pickImage(context);
                                }),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),

                  ///Button Add Product
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Builder(
                      builder: (context) => ButtonCustomWidget(
                        textbutton: 'Add Product',
                        onPressed: () {
                          submitProduct(context);
                        },
                        textColor: Colors.white,
                        backgroundColor: Color(0xffC34072),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitProduct(BuildContext context) async {
    final modelHud = Provider.of<ModelHud>(context, listen: false);

    modelHud.changeIsLoading(true);

    // ignore: await_only_futures
    await Provider.of<StorageImage>(context, listen: false).uploadImage(context);
    modelHud.changeIsLoading(true);
    final urlImage = Provider.of<StorageImage>(context, listen: false).url;

    if (_globalKey.currentState.validate() && urlImage != null) {
      _store.addProduct(
        ProductModel(
          pName: _name,
          pPrice: _price,
          pDescription: _description,
          pCategory: _category,
          pImageLocation: Provider.of<StorageImage>(context, listen: false).url,
        ),
      );
      modelHud.changeIsLoading(false);

      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Success Add Product ')));
      _globalKey.currentState.reset();
      Provider.of<StorageImage>(context, listen: false).fileImage = null;
      Provider.of<StorageImage>(context, listen: false).url = null;
    }
    modelHud.changeIsLoading(false);
    Provider.of<StorageImage>(context, listen: false).url = null;
    Provider.of<StorageImage>(context, listen: false).fileImage = null;
    print(
        ' Url image is :${Provider.of<StorageImage>(context, listen: false).url}');
  }

}
