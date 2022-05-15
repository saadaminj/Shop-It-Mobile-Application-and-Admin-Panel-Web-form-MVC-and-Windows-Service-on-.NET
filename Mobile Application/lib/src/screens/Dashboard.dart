import 'dart:convert';

import 'package:flutter/material.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/favourites.dart';
import '../shared/fryo_icons.dart';
import './ProductPage.dart';
import '../shared/Product.dart';
import '../shared/partials.dart';
import '../shared/scanner.dart';
import '../shared/mycoupons.dart';
import '../shared/qrcode.dart';
//import "package:mysql1/mysql1.dart";
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart' hide Row;
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
class Dashboard extends StatefulWidget {
  final String pageTitle;

  Dashboard({Key key, this.pageTitle}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}
Future<String> getwallet() async {
  var results = await http.get(Uri.parse("http://192.168.0.105/shopit/wallet.php"),  headers: {"Accept":"application/json"});


  for (var row in jsonDecode(results.body)) {
    //    print('Name: ${row[0]}, email: ${row[1]}');
    return row[0];
  }

}
class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  List<Product> foods;
  @override
  initState()
  {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _tabs = [
      storeTab(context),
      mycoupons(context),
//    Text('Tab'),
      favourites(context),
//      Image.network(
//        'https://raw.githubusercontent.com/saadaminj/Reverse-Shell-with-autorun/master/ss.jpg',
//        fit: BoxFit.cover,
//        height: double.infinity,
//        width: double.infinity,
//        alignment: Alignment.center,
//      ),
      scanner(),
//    Text("Tab"),
//      Image(
//        image: AssetImage(Image.network('https://picsum.photos/250?image=9')),
//
//      ),
      Text('Tab5'),
    ];

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {setState(() {});},
            iconSize: 21,
            icon: Icon(Icons.refresh),
          ),
          backgroundColor: primaryColor,
          title: Text('ShopIt',
              style: logoWhiteStyle, textAlign: TextAlign.center),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              iconSize: 21,
              icon: Icon(Fryo.magnifier),
            ),


            FutureBuilder(
                future: getwallet(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot)  {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none: return new Text('-');
                    case ConnectionState.waiting: return new Text('-');
                    default:
                      if (snapshot.hasError)
                        return  Text('Error: ${snapshot.error}');
                      else
                      {
                        return Center(child:Row(children:[Text("\$"+snapshot.data, style:TextStyle(fontSize:20,color:Colors.white,fontWeight: FontWeight.bold)),
                          //IconButton(icon: Icon(Icons.wallet_travel,color:Colors.white),onPressed:(){}),
                        ]),);
                      }


                  }
//                return new Text('Result: ${snapshot.data}');
                }
              // ignore: missing_return

            )


          ],
        ),
        body: _tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Fryo.shop),
                title: Text(
                  'Store',
                  style: tabLinkStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Fryo.cart),
                title: Text(
                  'Coupons',
                  style: tabLinkStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Fryo.heart_1),
                title: Text(
                  'Favourites',
                  style: tabLinkStyle,
                )),

            BottomNavigationBarItem(
                icon: Icon(Fryo.shop),
                title: Text(
                  'Scan',
                  style: tabLinkStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Fryo.cog_1),
                title: Text(
                  'Settings',
                  style: tabLinkStyle,
                ))
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green[600],
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
Future<List<Product>> liked(name) async {
  await http.get(Uri.parse("http://192.168.0.105/shopit/liked.php?name="+name),  headers: {"Accept":"application/json"});
}
Future<List<Product>> unliked(name) async {
  await http.get(Uri.parse("http://192.168.0.105/shopit/unliked.php?name="+name),  headers: {"Accept":"application/json"});
}
Future<List<Product>> called() async {
  var results = await http.get(Uri.parse("http://192.168.0.105/shopit/"),  headers: {"Accept":"application/json"});

  List<Product> foods = [];

  for (var row in jsonDecode(results.body)) {
    //    print('Name: ${row[0]}, email: ${row[1]}');
    foods.add(Product(
        name: row[0],
        image: row[1],
        price: row[2],
        userLiked: row[3]=="1",
        discount: row[4]));
  }

  print(jsonEncode(foods));
  developer.log(
    'log me',
    name: 'my.app.category',
    error: jsonEncode(foods),
  );
  return foods;
}

Widget storeTab(BuildContext context) {

  return ListView(//children: [Text("hello")]);
//    headerTopCategories(),
//      child: ListView(
        children: <Widget>[FutureBuilder(
          future: called(),
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
                                return new ProductPage(
                                  productData: snapshot.data[index],
                                );
                              },
                            ),
                          );
                        }, onLike: () {
                          if(snapshot.data[index].userLiked==true)
                            {
                              unliked(snapshot.data[index].name);
                            }
                          else
                            {
                              liked(snapshot.data[index].name);
                            }
//                          setState(() {});
                        });
                      }
                  )]);
                  }
            }

      ),]);
//  ));
}
Widget sectionHeader(String headerTitle, {onViewMore}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, top: 10),
        child: Text(headerTitle, style: h4),
      ),
      Container(
        margin: EdgeInsets.only(left: 15, top: 2),
        child: FlatButton(
          onPressed: onViewMore,
          child: Text('View all ›', style: contrastText),
        ),
      )
    ],
  );
}

// wrap the horizontal listview inside a sizedBox..
Widget headerTopCategories() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      sectionHeader('All Categories', onViewMore: () {}),
      SizedBox(
        height: 130,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            headerCategoryItem('Frieds', Fryo.dinner, onPressed: () {}),
            headerCategoryItem('Fast Food', Fryo.food, onPressed: () {}),
            headerCategoryItem('Creamery', Fryo.poop, onPressed: () {}),
            headerCategoryItem('Hot Drinks', Fryo.coffee_cup, onPressed: () {}),
            headerCategoryItem('Vegetables', Fryo.leaf, onPressed: () {}),
          ],
        ),
      )
    ],
  );
}

Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
  return Container(
    margin: EdgeInsets.only(left: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 86,
            height: 86,
            child: FloatingActionButton(
              shape: CircleBorder(),
              heroTag: name,
              onPressed: onPressed,
              backgroundColor: white,
              child: Icon(icon, size: 35, color: Colors.black87),
            )),
        Text(name + ' ›', style: categoryText)
      ],
    ),
  );
}

Widget deals(String dealTitle, {onViewMore, List<List<Widget>> items}) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sectionHeader(dealTitle, onViewMore: onViewMore),
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: (items != null)
                ? items
                : <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text('No items available at this moment.',
                          style: taglineText),
                    )
                  ],
          ),
        )
      ],
    ),
  );
}
