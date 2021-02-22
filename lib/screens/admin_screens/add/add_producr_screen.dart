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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductModel arg = ModalRoute.of(context).settings.arguments;

    return LayoutBuilder(builder: (context, con) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      final heightLocal = con.maxHeight;
      final widthLocal = con.maxWidth;
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            arg != null ? 'Edit Product' : 'Add Product',
            style: TextStyle(
              color: Colors.black,
              fontSize: widthLocal * 0.08,
              fontFamily: 'pacifico',
            ),
            textAlign: TextAlign.center,
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                /// Text Add Product

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(
                      children: [
                        SizedBox(height: heightLocal * 0.02),

                        /// TextForm Product Name
                        CustomTextFormWidget(
                          fontSize: widthLocal * 0.04,
                          initialText: arg != null ? arg.pName : null,
                          hint: 'Product Name',
                          label: null,
                          obscureText: false,
                          onChanged: (value) {
                            _name = value;
                          },
                          backgroundColor: kBackgroundColor,
                          textColor: kScandColor,
                        ),
                        SizedBox(height: heightLocal * 0.015),

                        /// TextForm Product Price
                        CustomTextFormWidget(
                          fontSize: widthLocal * 0.04,
                          initialText: arg != null ? arg.pPrice : null,
                          hint: 'Product Price',
                          label: null,
                          obscureText: false,
                          onChanged: (value) {
                            _price = value;
                          },
                          backgroundColor: kBackgroundColor,
                          textColor: kScandColor,
                        ),
                        SizedBox(height: heightLocal * 0.015),

                        /// TextForm Product Description
                        CustomTextFormWidget(
                          fontSize: widthLocal * 0.04,
                          initialText: arg != null ? arg.pDescription : null,
                          hint: 'Product Description',
                          label: null,
                          obscureText: false,
                          onChanged: (value) {
                            _description = value;
                          },
                          backgroundColor: kBackgroundColor,
                          textColor: kScandColor,
                        ),
                        SizedBox(height: heightLocal * 0.015),

                        /// TextForm Product Category
                        CustomTextFormWidget(
                          fontSize: widthLocal * 0.04,
                          initialText: arg != null ? arg.pCategory : null,
                          hint: 'Product Category',
                          label: null,
                          obscureText: false,
                          onChanged: (value) {
                            _category = value;
                          },
                          backgroundColor: kBackgroundColor,
                          textColor: kScandColor,
                        ),
                        SizedBox(height: heightLocal * 0.015),

                        /// choose image
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (Provider.of<StorageImage>(context,
                                            listen: false)
                                        .fileImage !=
                                    null) {
                                  Provider.of<StorageImage>(context,
                                          listen: false)
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
                                        width: widthLocal * 0.4,
                                        height: heightLocal * 0.2,
                                        color: kBackgroundColor,
                                        child: arg != null
                                            ? Image(
                                                image: NetworkImage(
                                                    arg.pImageLocation),
                                                fit: BoxFit.cover,
                                              )
                                            : Center(
                                                child: Text(
                                                'Add Product Image',
                                                style: TextStyle(
                                                  fontSize: widthLocal * 0.04,
                                                ),
                                              )),
                                      )
                                    : Stack(
                                        children: [
                                          Image(
                                            image: FileImage(
                                                Provider.of<StorageImage>(
                                                        context)
                                                    .fileImage),
                                            fit: BoxFit.cover,
                                            width: widthLocal * 0.4,
                                            height: heightLocal * 0.2,
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

                            ///  Icons.camera_alt
                            CircleAvatar(
                              radius: heightLocal * 0.04,
                              backgroundColor: kScandColor,
                              child: IconButton(
                                  color: kMainColor,
                                  icon: Icon(
                                    Icons.camera_alt,
                                    size: heightLocal * 0.04,
                                  ),
                                  onPressed: () {
                                    Provider.of<StorageImage>(context,
                                            listen: false)
                                        .pickImage(context);
                                  }),
                            ),

                            SizedBox(height: heightLocal * 0.02),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ///Button Add Product
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthLocal * 0.1,
                      vertical: heightLocal * 0.02),
                  child: Builder(
                    builder: (context) => ButtonCustomWidget(
                      fontSize: widthLocal * 0.04,
                      textbutton: arg == null ? 'Add Product' : 'Edit Product',
                      onPressed: () {
                        submitProduct(context);
                      },
                      textColor: kMainColor,
                      backgroundColor: kScandColor,
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

  void submitProduct(BuildContext context) async {
    final modelHud = Provider.of<ModelHud>(context, listen: false);

    modelHud.changeIsLoading(true);

    // ignore: await_only_futures
    await Provider.of<StorageImage>(context, listen: false)
        .uploadImage(context);
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
