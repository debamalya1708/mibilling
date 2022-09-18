import 'dart:convert';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mibilling/Screens/Login/Login.dart';
import 'package:mibilling/Screens/Order/Order.dart';
import 'package:mibilling/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navbar/navbar.dart';


class AllOrder extends StatefulWidget {
  const AllOrder({Key? key}) : super(key: key);

  @override
  State<AllOrder> createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> {

  List<dynamic> orderAllResponseData = [];

  @override
  void initState() {
    super.initState();

    GetAllOrders().then((value) =>
      setState(() {
        orderAllResponseData = value;
      })
    );


  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavBar(selectedIndex: 2,),
      appBar: AppBar(
        backgroundColor: primaryColor,
        // toolbarHeight: 0,
        centerTitle: true,
        title: const Text('Mi Billing'),
        elevation: 0,
        // automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          // padding: EdgeInsets.only(bottom: 500),
          child: Column(
            children: [
              Container(
                child: Text('Order Details:',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),)
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemCount: orderAllResponseData.length,
                    itemBuilder: (context, index) {
                      return Card(
                            elevation: 1,
                            child: ListTile(
                              title: Text('Order No: '+ orderAllResponseData[index]["orderNumber"].toString(), style: TextStyle(fontWeight: FontWeight.w600),),
                              leading: Icon(Icons.shopping_cart_outlined, color: primaryColor,),
                              trailing: Icon(Icons.arrow_forward_ios_rounded, color: primaryColor,),
                              subtitle: Text('Order Date: '+ orderAllResponseData[index]["orderDate"] + "\n" + 'Name: '+  orderAllResponseData[index]["orderDetails"]["user"]["name"]+ "\n" + 'Amount: '+  orderAllResponseData[index]["totalPrice"]),
                              onTap: () {
                                GetOneOrder(orderAllResponseData[index]["orderNumber"]).then((value) =>
                                GetFinalOutputData(value)
                                );
                              },
                            )
                        );

                    }),
              )
            ],
          ),
        ),
      ),
    );
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

  showSnackbar(String snackBarText, {bool showMargin = true}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(snackBarText),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xE62DA2B1),
      margin: showMargin ? const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0) : null,
    ));
  }

  Future<List<dynamic>> GetAllOrders() async {
    List<dynamic> orderAllResponseData = [];
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? oxygenToken = pref.getString('oxygen_token');
      Map<String, dynamic> decodedToken = parseJwtPayLoad(oxygenToken!);
      bool refresh = refreshRequired(decodedToken["exp"]);
      if(!refresh){
        http.Response? new_response;
        new_response = await http.get(
          Uri.parse("http://mibilling.herokuapp.com/order/all"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer $oxygenToken"
          },
        );
        if (new_response.statusCode == 200) {
          orderAllResponseData = jsonDecode(new_response.body);
          // Navigator.of(context).pop();
        }
        else{
          // Navigator.of(context).pop();
          showSnackbar('Unexpected Error. Try Again.');
        }
      }
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      }
    }
    catch(e){
      // Navigator.of(context).pop();
      showSnackbar('Unexpected Error Occurred!!');
    }
    return orderAllResponseData;
  }

  Future<Map<String, dynamic>> GetOneOrder(String orderId) async {
    Map<String, dynamic> orderOneResponseData = {};
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? oxygenToken = pref.getString('oxygen_token');
      Map<String, dynamic> decodedToken = parseJwtPayLoad(oxygenToken!);
      bool refresh = refreshRequired(decodedToken["exp"]);
      // print(refresh);
      if(!refresh){
        http.Response? new_response;
        new_response = await http.get(
          Uri.parse("http://mibilling.herokuapp.com/order/search/${orderId}"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer $oxygenToken"
          },
        );
        if (new_response.statusCode == 200) {
          orderOneResponseData = jsonDecode(new_response.body);
          Navigator.of(context).pop();
        }
        else{
          Navigator.of(context).pop();
          showSnackbar('Unexpected Error. Try Again.');
        }
      }
      else{
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      }
    }
    catch(e){
      // Navigator.of(context).pop();
      showSnackbar('Unexpected Error Occurred!!');
    }
    return orderOneResponseData;
  }

  GetFinalOutputData(Map<String, dynamic> value){
    List<Map<String, dynamic>>finalOutputData = [];
    Map<String, dynamic> userPersonalDetails = {};
    Map<String, dynamic> orderitemFinal = {};
    // print(value);

    userPersonalDetails.putIfAbsent('username', () => value['orderDetails']['user']['name']);
    userPersonalDetails.putIfAbsent('email', () => value['orderDetails']['user']['email']);
    userPersonalDetails.putIfAbsent('phone', () => value['orderDetails']['user']['contact']);
    userPersonalDetails.putIfAbsent('deliveryAddress', () => 'Building: ' + value['orderDetails']['user']['buildingName'].toString() +
        ', Street: ' + value['orderDetails']['user']['streetNo'].toString() + ', ' + value['orderDetails']['user']['address1'].toString()
        + ', ' + value['orderDetails']['user']['address2'].toString() + ', Dist: ' + value['orderDetails']['user']['district'].toString()
        + ', State: ' + value['orderDetails']['user']['state'].toString() + ', Pin: ' + value['orderDetails']['user']['pin'].toString());
    userPersonalDetails.putIfAbsent('username', () => value['orderDetails']['user']);

    Map<String,  dynamic> orderedItemsDetails = {};


    for (var items in value['orderDetails']['orderedItemList']){
      items.putIfAbsent('count', () => items['quantity']);
      orderedItemsDetails.putIfAbsent(items['sku'].toString(), () => items);
    }


    orderitemFinal.putIfAbsent('orderItems', () => orderedItemsDetails);
    orderitemFinal.putIfAbsent('orderNo', () => value['orderNumber']);
    orderitemFinal.putIfAbsent('invoiceNo', () => value['invoiceId']);
    orderitemFinal.putIfAbsent('paymentType', () => value['paymentType']);
    orderitemFinal.putIfAbsent('invoiceDate', () => value['invoiceDate']);

    finalOutputData.add(userPersonalDetails);
    finalOutputData.add(orderitemFinal);

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Order(finalOutput : finalOutputData, btnshow: false)));


  }

}
