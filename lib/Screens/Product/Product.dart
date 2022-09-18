import 'package:flutter/material.dart';
import 'package:mibilling/constants.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mibilling/Screens/Order/Order.dart';

class Product extends StatefulWidget {
  Map<String, String> newData = {};
  List<dynamic> productAll = [];
  Product({Key? key, required this.newData, required this.productAll}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

  List<String> productSKU = [];
  Map<String, dynamic> AllproductDataFinal = {};
  Map<String,  Map<String, String>> orderedItemsDetails = {};
  List<String> OrderSkuList = [];
  Map<String, String> userOrderData = {};
  var productSKUNoController = TextEditingController();
  String orderNumbergen = '';
  String invcNumbergen = '';

  @override
  void initState() {
    super.initState();
    Map<String, String> userOrderData = widget.newData;
    List<dynamic> productAllData = widget.productAll;
    // print(userOrderData);

    List<String> productSKUList =[];
    Map<String, dynamic> AllProductData = {};



    for (Map i in productAllData) {
      productSKUList.add(i['sku']);
      AllProductData.putIfAbsent(i['sku'], () => i);
    }

    setState(() {
      productSKU = productSKUList;
      AllproductDataFinal = AllProductData;
      orderNumbergen = orderNumbergenerator();
      invcNumbergen = invcNumbergenerator();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        // toolbarHeight: 0,
        centerTitle: true,
        title: const Text('MI Billing'),
        elevation: 0,
        // automaticallyImplyLeading: false,

      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 15,),
                Container(
                    child: Text('Bill Details:',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),)
                ),
                Container(
                  padding: EdgeInsets.only(right: 35, left: 35, bottom: 10),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    maintainState: true,
                    title: Text('Bill Info',
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    children: [
                      Container(
                        // padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('Order Details:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Order No : ${orderNumbergen}'),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Order Date : '+ widget.newData['deliveryDate'].toString()),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('Invoice Details:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text('Invoice No : ${invcNumbergen}'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Invoice Date : '+ widget.newData['deliveryDate'].toString()),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('Customer Details:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Customer Name : ' + widget.newData["name"].toString()),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Contact No : '+ widget.newData['phone'].toString()),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Email Id : '+ widget.newData['email'].toString())
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text('Address : Building: ' + widget.newData['building'].toString() + ', Street: '
                                        + widget.newData['street'].toString() + ', ' + widget.newData['address1'].toString()
                                        + ', ' + widget.newData['address2'].toString() + ', Dist: '
                                        + widget.newData['district'].toString() + ', State: '
                                        + widget.newData['state'].toString() + ', Pin: ' + widget.newData['pin'].toString()
                                    )
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('Delivery Details:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Delivery Type : ' + widget.newData['deliveryType'].toString()),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Delivery Date : ' + widget.newData['deliveryDate'].toString()),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Payment Type : '+ widget.newData['paymentType'].toString()),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
                Container(
                    child: Text('Add Products:',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(right: 25, left:25),
                  child: suggestInputField('Product SKU', productSKUNoController,Icons.add_shopping_cart_rounded,AllproductDataFinal),
                ),
                Expanded(
                  child: Container(
                    child: orderedItemsDetails.length > 0 ? productListTile() : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          GetFinalOutputData();
        },
        label: const Text('CheckOut'),
        icon: const Icon(Icons.payment),
        backgroundColor: Color(0xE8FD500C),
      ),

    );
  }

  Widget suggestInputField(String labelText, TextEditingController textController, IconData icons, AllproductDataDetails) {

    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: () => showSnackbar('Scan Barcode'),
            ),
          ),
          filled: true,
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Icon(icons,color: primaryColor,),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: primaryColor,width: 0.0),
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: primaryColor,width: 1.0),
          ),
        ),
        controller: textController,
        maxLength : 10,
        cursorColor : Colors.red,
        // autofocus: true,
        style: TextStyle(color: Colors.black),
        onSubmitted : (value) {
          textController.text = value.toString();
          Map userOtherDetails = AllproductDataDetails[textController.text.toString()];
          Map<String, String> order = {};
          order.putIfAbsent('name', () => userOtherDetails['name']);
          order.putIfAbsent('sku', () => userOtherDetails['sku']);
          order.putIfAbsent('category', () => userOtherDetails['category']);
          order.putIfAbsent('price', () => userOtherDetails['price'].toString());
          order.putIfAbsent('count', () => '1');
          if (orderedItemsDetails.containsKey(order['sku'])){
            orderedItemsDetails[order['sku']]!['count'] = (int.parse(orderedItemsDetails[order['sku']]!['count'].toString()) + 1).toString();
          }else{
            orderedItemsDetails.putIfAbsent(textController.text, () => order);
          }
          setState(() {
            orderedItemsDetails = orderedItemsDetails;
            textController.text = '';
          });
        },
        textInputAction : TextInputAction.next,
        // onChanged: (value){
        //   textController.text = value;
        //   print(textController.text.toString());
        // },
      ),
      suggestionsCallback: (pattern) async {
        return await getSKUSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.toString()),
        );
      },
      // noItemsFoundBuilder : (context){
      //   return ListTile(
      //     title: Text('Create New Entry') ,
      //   );
      // },
      onSuggestionSelected: (suggestion) {
        textController.text = suggestion.toString();
        Map userOtherDetails = AllproductDataDetails[textController.text.toString()];
        Map<String, String> order = {};
        order.putIfAbsent('name', () => userOtherDetails['name']);
        order.putIfAbsent('sku', () => userOtherDetails['sku']);
        order.putIfAbsent('category', () => userOtherDetails['category']);
        order.putIfAbsent('price', () => userOtherDetails['price'].toString());
        order.putIfAbsent('count', () => '1');
        if (orderedItemsDetails.containsKey(order['sku'])){
          orderedItemsDetails[order['sku']]!['count'] = (int.parse(orderedItemsDetails[order['sku']]!['count'].toString()) + 1).toString();
        }else{
          orderedItemsDetails.putIfAbsent(textController.text, () => order);
        }
        setState(() {
          orderedItemsDetails = orderedItemsDetails;
          textController.text = '';
        });
      },
    );
  }

  List<String> getSKUSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(productSKU);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  productListTile() {
    List<Widget> orderTilesList = [];
    for (String item in orderedItemsDetails.keys){
      orderTilesList.add(productTile(orderedItemsDetails[item]));
    };
    return Column(
      children: orderTilesList,
    );
  }

  Widget productTile(Orderitem) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 15),
      child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius : BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))),
                        child: Icon(Icons.ice_skating_outlined),
                        padding: EdgeInsets.all(15),
                      )
                    ],
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize : MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              // decoration: BoxDecoration(color: Colors.blue),
                              child: Text(
                                Orderitem['name'],
                                style: TextStyle(fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              padding: EdgeInsets.only(top:3,left: 5, right: 5),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              // decoration: BoxDecoration(color: Colors.blue),
                              child: Text(
                                Orderitem['category'],
                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                                textAlign: TextAlign.center,
                              ),
                              padding: EdgeInsets.only(top:3,left: 5, right: 5),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(

                          child: Text(
                                  Orderitem['price'],
                                  style: TextStyle(fontWeight: FontWeight.w600,
                                  color: Colors.black54),
                                  textAlign: TextAlign.center,
                          ),
                          // padding: EdgeInsets.all(15),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [

                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius : BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))),
                            child: Text(
                                Orderitem['count'],
                              style: TextStyle(fontWeight: FontWeight.w800,fontSize: 25,
                                  color: Colors.black87),
                              textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.only(right: 15)
                          )
                        )

                      ],
                    ),
                  ),
                ],
              )
            ],
          )


      ),



      // Text(Orderitem[ke]['name'])
    );
  }

  GetFinalOutputData(){
    List<Map<String, dynamic>>finalOutputData = [];
    Map<String, dynamic> userPersonalDetails = {};
    Map<String, dynamic> orderitemFinal = {};

    userPersonalDetails.putIfAbsent('username', () => widget.newData['name']);
    userPersonalDetails.putIfAbsent('email', () => widget.newData['email']);
    userPersonalDetails.putIfAbsent('phone', () => widget.newData['phone']);
    userPersonalDetails.putIfAbsent('deliveryAddress', () => 'Building: ' + widget.newData['building'].toString() +
        ', Street: ' + widget.newData['street'].toString() + ', ' + widget.newData['address1'].toString()
        + ', ' + widget.newData['address2'].toString() + ', Dist: ' + widget.newData['district'].toString()
        + ', State: ' + widget.newData['state'].toString() + ', Pin: ' + widget.newData['pin'].toString());
    userPersonalDetails.putIfAbsent('username', () => widget.newData['name']);


    orderitemFinal.putIfAbsent('orderItems', () => orderedItemsDetails);
    orderitemFinal.putIfAbsent('orderNo', () => orderNumbergen);
    orderitemFinal.putIfAbsent('invoiceNo', () => invcNumbergen);
    orderitemFinal.putIfAbsent('paymentType', () => widget.newData['paymentType']);
    orderitemFinal.putIfAbsent('invoiceDate', () => widget.newData['deliveryDate']);

    finalOutputData.add(userPersonalDetails);
    finalOutputData.add(orderitemFinal);

    // print(finalOutputData);

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Order(finalOutput : finalOutputData, btnshow:true)));


  }

  showSnackbar(String snackBarText, {bool showMargin = true}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(snackBarText),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xE62DA2B1),
      margin: showMargin ? const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0) : null,
    ));
  }

  orderNumbergenerator(){
    var rng = new Random();
    int ord = rng.nextInt(90000) + 10000;
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    return ord.toString() + timestamp.toString();
  }

  invcNumbergenerator(){
    var r = Random();
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(6, (index) => _chars[r.nextInt(_chars.length)]).join() + '-' + timestamp.toString() + '-' + List.generate(7, (index) => _chars[r.nextInt(_chars.length)]).join();

  }

}

