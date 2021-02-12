import 'dart:io';

import 'package:e_commerce/constans.dart';
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

class EditProductScreen extends StatefulWidget {
  static String id = 'EditProductScreen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  String _name, _price, _description, _category;

  final StoreDataBase _store = StoreDataBase();
  final StorageImage _manageImage = StorageImage();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProductModel arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
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
                    'Edit Product',
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
                    initialText: arg.pName,
                    hint: 'Product Name',
                    label: null,
                    obscureText: false,
                    onChanged: (value) {
                      arg.pName = value;
                    },
                    backgroundColor: Colors.black12,
                    textColor: Color(0xffC34072),
                  ),
                  SizedBox(height: 20),

                  /// TextForm Product Price
                  CustomTextFormWidget(
                    initialText: arg.pPrice,
                    hint: 'Product Price',
                    label: null,
                    obscureText: false,
                    onChanged: (value) {
                      arg.pPrice = value;

                      // _price = value;
                    },
                    backgroundColor: Colors.black12,
                    textColor: Color(0xffC34072),
                  ),
                  SizedBox(height: 20),

                  /// TextForm Product Description
                  CustomTextFormWidget(
                    initialText: arg.pDescription,
                    hint: 'Product Description',
                    label: null,
                    obscureText: false,
                    onChanged: (value) {
                      arg.pDescription = value;
                    },
                    backgroundColor: Colors.black12,
                    textColor: Color(0xffC34072),
                  ),
                  SizedBox(height: 20),

                  /// TextForm Product Category
                  CustomTextFormWidget(
                    initialText: arg.pCategory,
                    hint: 'Product Category',
                    label: null,
                    obscureText: false,
                    onChanged: (value) {
                      arg.pCategory = value;
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (Provider.of<StorageImage>(context,
                                              listen: false)
                                          .fileImage !=
                                      null ||
                                  arg.pImageLocation != null) {
                                // _manageImage.openImage(context);
                                await Provider.of<StorageImage>(context,
                                        listen: false)
                                    .openImage(context, arg.pImageLocation);
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
                              child:
                                  Provider.of<StorageImage>(context).fileImage ==
                                          null
                                      ? Image(
                                          image: NetworkImage(
                                              Provider.of<StorageImage>(context,
                                                              listen: false)
                                                          .updateImageUrl ==
                                                      null
                                                  ? arg.pImageLocation
                                                  : Provider.of<StorageImage>(
                                                          context,
                                                          listen: false)
                                                      .updateImageUrl),
                                          fit: BoxFit.cover,
                                          width: 200,
                                          height: 150,
                                        )
                                      : Image(
                                          image: FileImage(
                                              Provider.of<StorageImage>(context)
                                                  .fileImage),
                                          fit: BoxFit.cover,
                                          width: 200,
                                          height: 150,
                                        ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              /// Chose Image
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

                              /// upload Image
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.4,
                              //   child: Builder(
                              //     builder: (context) => ButtonCustomWidget(
                              //         textbutton: 'updateImage',
                              //         onPressed: () {
                              //           Provider.of<ManageImage>(context,
                              //                   listen: false)
                              //               .updateUrlImage(
                              //                   context, arg.pImageLocation);
                              //         },
                              //         backgroundColor: Color(0xffC34072),
                              //         textColor: Colors.white),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),

                  ///Button Edit Product
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Builder(
                      builder: (context) => ButtonCustomWidget(
                        textbutton: 'Edit Product',
                        onPressed: () async {
                          await submitEdit(context, arg);
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

  Future submitEdit(BuildContext context, ProductModel arg) async {
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);


    if (Provider.of<StorageImage>(context,listen: false).fileImage != null) {
      await Provider.of<StorageImage>(context, listen: false)
          .updateUrlImage(context, arg.pImageLocation);
    }
    final imageUrl =
        Provider.of<StorageImage>(context, listen: false).updateImageUrl;

    if (_globalKey.currentState.validate()) {
      await _store.editProduct(
          ({
            kProductName: arg.pName,
            kProductDescription: arg.pDescription,
            kProductPrice: arg.pPrice,
            kProductCategory: arg.pCategory,
            kProductImageLocation:
                imageUrl == null ? arg.pImageLocation : imageUrl,
          }),
          arg.pId);

      modelHud.changeIsLoading(false);

      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Success Edit Product ')));
      Provider.of<StorageImage>(context, listen: false).fileImage = null;
      // Provider.of<ManageImage>(context, listen: false).url = null;
    }
    modelHud.changeIsLoading(false);

    // _globalKey.currentState.reset();
    Provider.of<StorageImage>(context, listen: false).fileImage = null;
    // Provider.of<ManageImage>(context, listen: false).url = null;

    Navigator.pop(context);
  }
}
