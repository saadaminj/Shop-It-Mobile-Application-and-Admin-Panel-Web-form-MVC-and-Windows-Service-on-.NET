import 'package:flutter/material.dart';
import 'Product.dart';
import 'styles.dart';
import 'colors.dart';
import 'partials.dart';
import 'buttons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
class ProductPage2 extends StatefulWidget {
  final String pageTitle;
  final Product productData;

  ProductPage2({Key key, this.pageTitle, this.productData}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}
Future<List<Product>> buying(name) async {
  await http.get(Uri.parse("http://192.168.0.105/shopit/buy.php?name="+name),  headers: {"Accept":"application/json"});
}
class _ProductPageState extends State<ProductPage2> {
  double _rating = 4;
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          centerTitle: true,
          leading: BackButton(
            color: darkText,
          ),
          title: Text(widget.productData.name, style: h4),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(top: 100, bottom: 50),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.productData.name, style: h5),
                            Center(
                              child:Container(

                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                    width: 700,
                                    height: 300,
  //                        child: foodItem(widget.productData,
  //                            isProductPage: true,
  //                            onTapped: () {},
  //                            imgWidth: 250,
  //                            onLike: () {}),
                                    child: //Text(''),
                                    Container(

                                        alignment: Alignment.topCenter,
                                      child: QrImage(
                                      data: widget.productData.name,
                                      version: QrVersions.auto,
                                      size: 400,
                                      gapless: true,
                                    )
                                    )
                                ),
                              )
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                  color: Color.fromRGBO(0, 0, 0, .05))
                            ]),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
//                      child:
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
