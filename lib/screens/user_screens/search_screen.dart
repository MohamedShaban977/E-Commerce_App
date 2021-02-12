import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/services/storeDataBase.dart';
import 'package:flutter/material.dart';

import '../../constans.dart';
import 'product_info_screen.dart';


class DataSearch extends SearchDelegate<String> {
  final _store = StoreDataBase();
  List<ProductModel> products = [];
  List<ProductModel> list = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        color: kMainColor,
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? list
        : products.where((element) {
      // if (element.pName.startsWith(query)) {
      //   return element.pName.startsWith(query);
      // }
      // if (element.pDescription.startsWith(query)) {
      //   return element.pDescription.startsWith(query);
      // }
      // if (element.pName.contains(query)) {
      //   return element.pName.contains(query);
      // }
      // if (element.pDescription.contains(query)) {
      //   return element.pDescription.contains(query);
      // } else {
      //   return element.pName.startsWith(query);
      // }
      return element.pName.startsWith(query);
    }).toList();

    return StreamBuilder<QuerySnapshot>(
        stream: _store.manageProduct(),
        builder: (context, snapshot) {
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: suggestionsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, ProductInfo.id,
                              arguments: suggestionsList[index]);
                        },
                        leading: Image(
                          image: NetworkImage(
                              suggestionsList[index].pImageLocation),
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                        title: RichText(
                          text: TextSpan(
                              text: suggestionsList[index]
                                  .pName
                                  .substring(0, query.length),
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: suggestionsList[index]
                                      .pName
                                      .substring(query.length),
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ]),
                        ),
                        subtitle: Text(suggestionsList[index].pDescription),
                      ),
                    );
                  }),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
