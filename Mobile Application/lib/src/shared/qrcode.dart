//import 'package:qr_flutter/qr_flutter.dart';
//
//import 'package:flutter/material.dart';
//import '../shared/Product.dart';
//import '../shared/colors.dart';
//import '../shared/styles.dart';
//
//Widget qrcode() {
//
//  return Container(
//    width: 180,
//    height: 180,
//    // color: Colors.red,
//    margin: EdgeInsets.only(left: 20,top:10,bottom:10,),
//    child: Stack(
//      children: <Widget>[
//        Container(
//            width: 180,
//            height: 180,
//            child: RaisedButton(
//                color: white,
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(5)),
//                onPressed: (){},
//                child: Hero(
//                  tag:Text('hello'),
//                    transitionOnUserGestures: true,
//                    child: QrImage(
//                      data: 'This QR code has an embedded image as well',
//                      version: QrVersions.auto,
//                      size: 320,
//                      gapless: false,
//                      embeddedImage: AssetImage('assets/images/my_embedded_image.png'),
//                      embeddedImageStyle: QrEmbeddedImageStyle(
//                      size: Size(80, 80),
//                      ),
//                      )
//                )
//            )
//        )
//      ],
//    ),
//  );
//}
