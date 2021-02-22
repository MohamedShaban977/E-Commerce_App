import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/provider/favorite_itme.dart';
import 'package:e_commerce/screens/user_screens/product_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constans.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
              padding: EdgeInsets.symmetric(horizontal: widthLocal * 0.08),
              child: Icon(
                FontAwesomeIcons.solidHeart,
                color: Color(0xffDB5758),
                size: widthLocal * 0.04,
              ),
            ),
          ],
          title: Text(
            'My Favorite',
            style: TextStyle(fontSize: widthLocal * 0.04, color: kMainColor),
          ),
          backgroundColor: kScandColor,
          // elevation: 0,
        ),
        body: FutureBuilder<List<ProductModel>>(
            future: Provider.of<FavoriteItem>(context, listen: false)
                .gatAllFavorite(),
            builder: (context, snapshot) {
              List<ProductModel> listFavorite = snapshot.data;
              print(listFavorite);
              if (snapshot.hasData) {
                if (listFavorite == null ||
                    listFavorite.length == 0 ||
                    listFavorite == []) {
                  return Center(
                    child: Container(
                      width: width,
                      height: height,
                      child: Image(
                        image: AssetImage('images/empty-favorites.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(
                                          image: NetworkImage(
                                              listFavorite[index]
                                                  .pImageLocation),
                                          fit: BoxFit.fill,
                                          height: heightLocal * 0.25,
                                          width: widthLocal * 0.25,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: widthLocal * 0.5,
                                            child: Text(
                                              listFavorite[index].pName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: widthLocal * 0.04),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Category : ' +
                                                listFavorite[index]
                                                    .pCategory
                                                    .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: widthLocal * 0.04,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Price : ' +
                                                listFavorite[index].pPrice,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: widthLocal * 0.04,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      // mainAxisAlignment:,
                                      // mainAxisAlignment,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, ProductInfo.id,
                                                arguments: listFavorite[index]);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.visibility,
                                              color: Colors.black45,
                                              size: widthLocal * 0.04,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Provider.of<FavoriteItem>(context,
                                                    listen: false)
                                                .deleteProductToFavorite(
                                                    listFavorite[index].pId);
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              FontAwesomeIcons.heartBroken,
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
                      });
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      );
    });
  }
}
