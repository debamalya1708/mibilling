import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mibilling/Screens/Login/Login.dart';
import 'package:mibilling/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';


class Order extends StatefulWidget {
  List<Map<String, dynamic>> finalOutput = [];
  bool btnshow;
  Order({Key? key, required this.finalOutput, required this.btnshow}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}


class _OrderState extends State<Order> {
  Map<String, dynamic>final_order_details = {};
  double totalPrice = 0;
  int serial = 0;
  bool payOnline = false;
  bool genpdfbtn = false;
  List<TableRow>finaltableRows = [];
  @override
  void initState() {
    super.initState();

    setState(() {
      finaltableRows = getProductsAllRows();

      if (widget.btnshow == true){
        if (widget.finalOutput[1]["paymentType"].toString().toLowerCase() == 'online'){
          payOnline = true;
        }else if(widget.finalOutput[1]["paymentType"].toString().toLowerCase() != 'online'){
          payOnline = false;
          genpdfbtn = true;
        }
      }else{
        payOnline = false;
        genpdfbtn = false;
      }

    });



  }

  @override
  Widget build(BuildContext context) {
    Size _mediaQuery = MediaQuery.of(context).size;
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        // toolbarHeight: 0,
        // centerTitle: true,
        title: const Text('Invoice Details'),
        elevation: 0,
        automaticallyImplyLeading: false,

      ),
      body: Container(
        child : SingleChildScrollView (
          child: Column(
            children: [
              SizedBox(height: 15,),
              Container(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        width: _mediaQuery.width * 0.15,
                        child: Image.asset("assets/images/login.png",height: _mediaQuery.height *0.03,),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 90),
                          width: _mediaQuery.width * 0.85,
                          child: Text('Invoice',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),))
                    ],
                  )

              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20, top: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex : 5,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text('Invoice Number : \n' + widget.finalOutput[1]['invoiceNo'],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      flex : 5,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text('Invoice Date : ' + widget.finalOutput[1]['invoiceDate'].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20, top: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex : 5,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text('Order Number : ' + widget.finalOutput[1]['orderNo'],
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      flex : 5,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text('Payment Method : ' + widget.finalOutput[1]['paymentType'].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20, top: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex : 10,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text('Customer Details : ',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),)
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex : 10,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text('${widget.finalOutput[0]["username"]}'+'\n${widget.finalOutput[0]["phone"]}' +'\n${widget.finalOutput[0]["email"]}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,),)
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20,),
                child: Row(
                  children: [
                    Expanded(
                      flex : 10,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text('Billing Address : ',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),)
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex : 10,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text('${widget.finalOutput[0]["deliveryAddress"]}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,),)
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20, top:10),
                child: Row(
                  children: [
                    Expanded(
                      flex : 10,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text('Sold By : ',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),)
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex : 10,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text('Xiaomi Technology India Private Limited, \nBuilding Orchid, Block E, Embassy Tech Village, \nMarathahalli Outer Ring Road, Devarabisanahalli,\nBengaluru - 560103.',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,),)
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20, top: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex : 10,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text('Item Details : ',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),)
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20, top: 5),
                child: Column(
                    children: [
                      Table(
                        textDirection: TextDirection.ltr,
                        defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                        // border:TableBorder.all(width: 1.0,color: Colors.orangeAccent),
                        children: finaltableRows
                      )
                    ]
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20, top: 5),
                child: Divider(
                  thickness: 1, // thickness of the line// empty space to the trailing edge of the divider.
                  color: Colors.black54, // The color to use when painting the line.
                  height: 5,
                ),
              ),
              Container(
                padding: EdgeInsets.only(right:20, left: 20, top: 2),
                child: Column(
                    children: [
                      Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                          // border:TableBorder.all(width: 1.0,color: Colors.orangeAccent),
                          children: [
                            TableRow(
                                children: [
                                  Text("",),
                                  Text("",),
                                  Center(child: Text("Total",style:TextStyle(fontSize: 15,))),
                                  Center(child :Text('${totalPrice}'.toString(),style:TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                                ]
                            ),
                          ]
                      )
                    ]
                ),
              ),
              SizedBox(height: 60,),
              Visibility(
                visible: genpdfbtn,
                child: Container(
                    padding: EdgeInsets.only(right:20, left: 20),
                    child: Container(
                      child: FloatingActionButton.extended(
                        label: Text('Generate invoice'), // <-- Text
                        backgroundColor: primaryColor,
                        icon: Icon( // <-- Icon
                          Icons.note_add_sharp,
                          size: 24.0,
                        ),
                        onPressed: () async {

                          generateFinalJson();

                          showDialog(context: context, barrierDismissible: false, builder: (context) {
                            return WillPopScope(
                              onWillPop: () => Future.value(false),
                              child: Center(child: SpinKitFoldingCube(
                                size: 50,
                                color: Colors.orange,
                              ),),
                            );
                          });

                          try{
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            String? oxygenToken = pref.getString('oxygen_token');
                            Map<String, dynamic> decodedToken = parseJwtPayLoad(oxygenToken!);

                            bool refresh = refreshRequired(decodedToken["exp"]);

                            if(!refresh){
                              http.Response? new_response;
                              new_response = await http.post(
                                  Uri.parse("http://mibilling.herokuapp.com/order/save"),
                                  headers: {
                                    HttpHeaders.contentTypeHeader: "application/json",
                                    "Authorization": "Bearer $oxygenToken"
                                  },
                                  body: json.encode(final_order_details)
                              );
                              if (new_response.statusCode == 200) {
                                Navigator.of(context).pop();
                                showSnackbar('Invoice Mailed');
                                Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);

                              }
                              else{
                                Navigator.of(context).pop();
                                showSnackbar('Unexpected Error. Try Again.');
                              }
                            }
                            else{
                              // drafs save needed
                              showSnackbar('Log In Again!!');
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                            }

                          }
                          catch(e){
                            Navigator.of(context).pop();
                            showSnackbar('order place : Unexpected Error Occurred!!');
                          }

                        },
                      ),
                    )
                ),
              ),
              Visibility(
                visible: payOnline,
                child: Container(
                    padding: EdgeInsets.only(right:20, left: 20),
                    child: Container(
                      child: FloatingActionButton.extended(
                        label: Text('Pay Now'), // <-- Text
                        backgroundColor: primaryColor,
                        icon: Icon( // <-- Icon
                          Icons.currency_rupee_rounded,
                          size: 24.0,
                        ),
                        onPressed: () async {

                          generateFinalJson();

                          showDialog(context: context, barrierDismissible: false, builder: (context) {
                            return WillPopScope(
                              onWillPop: () => Future.value(false),
                              child: Center(child: SpinKitFoldingCube(
                                size: 50,
                                color: Colors.orange,
                              ),),
                            );
                          });

                          try{
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            String? oxygenToken = pref.getString('oxygen_token');
                            Map<String, dynamic> decodedToken = parseJwtPayLoad(oxygenToken!);

                            bool refresh = refreshRequired(decodedToken["exp"]);

                            if(!refresh){
                              print('ami');
                              print(final_order_details);
                              http.Response? new_response;
                              new_response = await http.post(
                                  Uri.parse("http://mibilling.herokuapp.com/order/save"),
                                  headers: {
                                    HttpHeaders.contentTypeHeader: "application/json",
                                    "Authorization": "Bearer $oxygenToken"
                                  },
                                  body: json.encode(final_order_details)
                              );
                              if (new_response.statusCode == 200) {
                                Navigator.of(context).pop();
                                showSnackbar('Payment Success!!! Invoice sent in Mail.');
                                Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
                              }
                              else{
                                Navigator.of(context).pop();
                                showSnackbar('Unexpected Error. Try Again.');
                              }
                            }
                            else{
                              // drafs save needed
                              showSnackbar('Log In Again!!');
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                            }

                          }
                          catch(e){
                            Navigator.of(context).pop();
                            showSnackbar('order place : Unexpected Error Occurred!!');
                          }

                        },
                      ),
                    )
                ),
              ),

            ],
          ),
        )
      ),
    );
  }

  showSnackbar(String snackBarText, {bool showMargin = true}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(snackBarText),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.orange,
      margin: showMargin ? const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0) : null,
    ));
  }

  getProductsAllRows(){
    List<TableRow>tableRows = [];
    tableRows.add(TableRow(
        children: [
          Center(child: Text("Sl No.",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w700, color: Colors.black45))),
          Center(child: Text("Product",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w700, color: Colors.black45))),
      Center(child:Text("Qty",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w700, color: Colors.black45))),
      Center(child:Text("Price",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black45))),
        ]
    ));
    Map<String, dynamic> allItems = widget.finalOutput[1]['orderItems'];
    for (String itemKey in allItems.keys){
      tableRows.add(createProductRow(allItems[itemKey]));
    }
    return tableRows;
  }

  createProductRow(itemData){
    List<Widget> singleRow = [];
    // double totalPrice = 0;
    serial = serial + 1;
    totalPrice = totalPrice + (int.parse(itemData["count"]) * double.parse(itemData["price"]));
    singleRow.add(Center(child:Text('${serial}',style:TextStyle(fontSize: 12,))));
    singleRow.add(Center(child:Text('${itemData["name"]}',style:TextStyle(fontSize: 12,))));
    singleRow.add(Center(child:Text('${itemData["count"]}',style:TextStyle(fontSize: 12,))));
    singleRow.add(Center(child:Text('${itemData["price"]}',style:TextStyle(fontSize: 12,))));
    return TableRow(
        children: singleRow
    );
  }

  generateFinalJson(){

    Map<String, dynamic>final_cust_details = {};
    List<Map<String, String>>final_item_details = [];

    final_cust_details.putIfAbsent('name', () => widget.finalOutput[0]["username"]);
    final_cust_details.putIfAbsent('email', () => widget.finalOutput[0]["email"]);
    final_cust_details.putIfAbsent('contact', () => widget.finalOutput[0]["phone"]);
    final_cust_details.putIfAbsent('address1', () => widget.finalOutput[0]["deliveryAddress"]);

    Map<String, dynamic> allItems = widget.finalOutput[1]['orderItems'];
    for (String itemKey in allItems.keys){
      Map<String, String>finalone_item_details = {};
      finalone_item_details.putIfAbsent('sku', () => allItems[itemKey]["sku"].toString());
      finalone_item_details.putIfAbsent('quantity', () => allItems[itemKey]["count"].toString());
      finalone_item_details.putIfAbsent('name', () =>  allItems[itemKey]["name"].toString());
      finalone_item_details.putIfAbsent('price', () =>  allItems[itemKey]["price"].toString());
      final_item_details.add(finalone_item_details);
    }

    final_order_details.putIfAbsent("orderNumber", () => widget.finalOutput[1]['orderNo'].toString());
    final_order_details.putIfAbsent("orderDate", () => widget.finalOutput[1]['invoiceDate'].toString());
    final_order_details.putIfAbsent("invoiceId", () => widget.finalOutput[1]['invoiceNo'].toString());
    final_order_details.putIfAbsent("invoiceDate", () => widget.finalOutput[1]['invoiceDate'].toString());
    final_order_details.putIfAbsent("storeAddress", () => 'Xiaomi Technology India Private Limited, \nBuilding Orchid, Block E, Embassy Tech Village, \nMarathahalli Outer Ring Road, Devarabisanahalli,\nBengaluru - 560103.');
    final_order_details.putIfAbsent("paymentType", () => widget.finalOutput[1]['paymentType'].toString());
    final_order_details.putIfAbsent("totalPrice", () => totalPrice.toString());
    // final_order_details.putIfAbsent("pay_vendor_details", () => []);
    final_order_details.putIfAbsent("userContact", () => final_cust_details["contact"].toString());
    final_order_details.putIfAbsent("orderDetails", () => final_item_details);
    print(final_order_details);

  }

  Map<String, dynamic> parseJwtPayLoad(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    return payloadMap;
  }

  Map<String, dynamic> parseJwtHeader(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[0]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  bool refreshRequired(int dateTimeInt) {
    int tokenRefreshTimeLimit = 2;
    DateTime accessTokenDate = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).add(Duration(seconds: dateTimeInt));
    Duration validityTimeLimit = accessTokenDate.difference(DateTime.now());
    if(validityTimeLimit.inMinutes <= tokenRefreshTimeLimit){
      return true;
    }
    else
    {
      return false;
    }

  }

}