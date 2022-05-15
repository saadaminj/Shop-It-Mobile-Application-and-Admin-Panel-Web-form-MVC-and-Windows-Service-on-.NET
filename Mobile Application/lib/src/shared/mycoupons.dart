import 'dart:convert';

import 'package:flutter/material.dart';
import './styles.dart';
import './colors.dart';
import './fryo_icons.dart';
import './ProductPage2.dart';
import '../shared/Product.dart';
import '../shared/partials.dart';
//import '../shared/mycoupons.dart';
//import '../shared/qrcode.dart';
//import "package:mysql1/mysql1.dart";
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart' hide Row;
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

Future<List<Product>> getcoupons() async {
  var results = await http.get(Uri.parse("http://192.168.0.105/shopit/bought.php"),  headers: {"Accept":"application/json"});

  List<Product> foods = [];

  for (var row in jsonDecode(results.body)) {
    //    print('Name: ${row[0]}, email: ${row[1]}');
    foods.add(Product(
        name: row[0],
        image: row[1],
        price: row[2],
        userLiked: row[3]=="1",
        discount: row[6]));
  }

  print(jsonEncode(foods));
  developer.log(
    'log me',
    name: 'my.app.category',
    error: jsonEncode(foods),
  );
  return foods;
}

Widget mycoupons(BuildContext context) {

  return ListView(//children: [Text("hello")]);
//    headerTopCategories(),
//      child: ListView(
      children: <Widget>[FutureBuilder(
          future: getcoupons(),
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none: return new Text('Press button to start');
              case ConnectionState.waiting: return new Text('Awaiting result...');
              default:
                if (snapshot.hasError)
                  return  Text('Error: ${snapshot.error}');
                else
//
                  return Column(children:[ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap:true,
                      itemCount: snapshot.data.length,
//                        gridDelegate: (new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 9)),
                      itemBuilder: (BuildContext context, int index){
                        return foodItem(snapshot.data[index], onTapped: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
//                                return Text('text');
                                return new ProductPage2(
                                  productData: snapshot.data[index],
                                );
                              },
                            ),
                          );
                        }, );
                      }
                  )]);
            }
          }

      ),]);
//  ));
}