import 'package:qrscan/qrscan.dart' as scanner_;
import 'dart:convert';

import 'package:qr_code_scanner/qr_code_scanner.dart';
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
// Select Bar-Code or QR-Code photos for analysis
Future<String> scanner2()
{
  Future<String> cameraScanResult = scanner_.scan();
  return cameraScanResult;
}
class scanner extends StatefulWidget {
  @override
  _scannerState createState() => _scannerState();
}

class _scannerState extends State<scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                  'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }
}

//
//
//Widget scanner(BuildContext context) {
//  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//  Barcode result;
//  QRViewController controller;
//
//  return Container(
//    child: Column(
//      children: <Widget>[
//        Expanded(
//          flex: 5,
//          child: QRView(
//            key: qrKey,
//            onQRViewCreated: _onQRViewCreated,
//          ),
//        ),
//        Expanded(
//          flex: 1,
//          child: Center(
//            child: (result != null)
//                ? Text(
//                'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
//                : Text('Scan a code'),
//          ),
//        )
//      ],
//    ),
//  );
////  return ListView(//children: [Text("hello")]);
//////    headerTopCategories(),
//////      child: ListView(
////      children: <Widget>[FutureBuilder(
////          future: scanner2(),
////          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
////            switch (snapshot.connectionState) {
////              case ConnectionState.none: return new Text('Press button to start');
////              case ConnectionState.waiting: return new Text('Awaiting result...');
////              default:
////                if (snapshot.hasError)
////                  return  Text('Error: ${snapshot.error}');
////                else
//////
////                  return Column(children:[ListView.builder(
////                      physics: NeverScrollableScrollPhysics(),
////                      shrinkWrap:true,
////                      itemCount: 1,
//////                        gridDelegate: (new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 9)),
////                      itemBuilder: (BuildContext context, int index){
////                        return Text(snapshot.data[index]);
////                      }
////                  )]);
////            }
////          }
////
////      ),]);
////  ));
//}