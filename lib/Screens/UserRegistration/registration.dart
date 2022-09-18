import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mibilling/Screens/Login/Login.dart';
import 'package:mibilling/Screens/Product/Product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mibilling/Screens/navbar/navbar.dart';
import 'package:mibilling/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserRegistration extends StatefulWidget {
  List<dynamic> Alluserdata = [];
  UserRegistration({Key? key, required this.Alluserdata}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration>{
  List<String> userPhone = [];
  Map<String, dynamic> AllUserDataFinal = {};
  late String typingInputValue;
  bool registerVisible = false;
  DateTime todaysDate = DateTime.now();
  Map<String, TextEditingController> billInfoData = {};
  var CustomerContactNoController = TextEditingController();
  var CustomerEmailController = TextEditingController();
  var CustomerNameController = TextEditingController();
  var CustomerbuildingController = TextEditingController();
  var CustomerStreetController = TextEditingController();
  var Customeraddress1Controller = TextEditingController();
  var Customeraddress2Controller = TextEditingController();
  var CustomerdistrictController = TextEditingController();
  var CustomerstateController = TextEditingController();
  var CustomerPinController = TextEditingController();
  var DeliveryTypeController = TextEditingController();
  var PaymentTypeController = TextEditingController();
  var DeliverydateController = TextEditingController();


  @override
  void initState() {
    super.initState();
    List<dynamic> userAllData = widget.Alluserdata;
    List<String> userPhoneList =[];
    Map<String, dynamic> AllUserData = {};



    for (Map i in userAllData) {
      userPhoneList.add(i['contact']);
      AllUserData.putIfAbsent(i['contact'], () => i);
    }

    setState(() {
      userPhone = userPhoneList;
      AllUserDataFinal = AllUserData;
      DeliverydateController.text = DateFormat('dd-MM-yyyy').format(todaysDate).toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const NavBar(selectedIndex: 0,),
      appBar: AppBar(
        backgroundColor: primaryColor,
        // toolbarHeight: 0,
        centerTitle: true,
        title: const Text('MI Billing'),
        elevation: 0,
        // automaticallyImplyLeading: false,

      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: size.height*0.02,
              ),
              Container(
                child: Image.asset("assets/images/cover.png",height: size.height *0.05,),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Container(
                child: Text("Search Customer",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,),
                ),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Container(
                padding: EdgeInsets.only(right: 40, left: 40),
                child: suggestInputField('Customer Contact No', CustomerContactNoController,Icons.call, AllUserDataFinal),
                // child: buildValidationInputField("Customer Contact No.",CustomerContactNoController,'','',true,false,Icons.call) ,

              ),
              SizedBox(
                height: size.height*0.02,
              ),

              Container(
                padding: EdgeInsets.only(right: 35, left: 35),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  maintainState: true,
                  title: Text('User Details',
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  children: [
                    Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10,top: 10,bottom: 10),
                            child: buildValidationInputField("Email id",CustomerEmailController,'','',false,false,Icons.email) ,
                          ),
                          // RoundedInputEmailField(hintText: "Customer Email id",
                          //   onChanged: (value){},
                          // ),
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10,top: 10,bottom: 10),
                            child: buildValidationInputField("Name",CustomerNameController,'','',false,false,Icons.person) ,
                          ),
                          // RoundedInputNameField(hintText: "Customer Name",
                          //   onChanged: (value){},
                          // ),
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10,top: 10,bottom: 10),
                            child: buildValidationInputField("Building name/House No",CustomerbuildingController,'','',false,false,Icons.home) ,
                          ),
                          // RoundedInputAddressField(hintText: "Building name/House No",
                          //   onChanged: (value){},
                          // ),
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10,top: 10,bottom: 10),
                            child: buildValidationInputField("Street No.",CustomerStreetController,'','',false,false,Icons.home) ,
                          ),
                          // RoundedInputAddressField(hintText: "Street No.",
                          //   onChanged: (value){},
                          // ),
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10,top: 10,bottom: 10),
                            child: buildValidationInputField("Address 1",Customeraddress1Controller,'','',false,false,Icons.home) ,
                          ),
                          // RoundedInputAddressField(hintText: "Address 1",
                          //   onChanged: (value){},
                          // ),
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10,top: 10,bottom: 10),
                            child: buildValidationInputField("Address 2",Customeraddress2Controller,'','',false,false,Icons.home) ,
                          ),
                          // RoundedInputAddressField(hintText: "Address 2",
                          //   onChanged: (value){},
                          // ),
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10,top: 10,bottom: 10),
                            child: buildValidationInputField("District",CustomerdistrictController,'','',false,false,Icons.home) ,
                          ),
                          // RoundedInputAddressField(hintText: "District",
                          //   onChanged: (value){},
                          // ),
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10,top: 10,bottom: 10),
                            child: buildValidationInputField("State",CustomerstateController,'','',false,false,Icons.home) ,
                          ),
                          // RoundedInputAddressField(hintText: "State",
                          //   onChanged: (value){},
                          // ),
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10,top: 10,bottom: 10),
                            child: buildValidationInputField("Pin No.",CustomerPinController,'','',false,false,Icons.home) ,
                          ),
                          // RoundedInputAddressField(hintText: "Pin No.",
                          //   onChanged: (value){},
                          // ),
                        ]
                    ),


                  ],
                ),
              ),
              SizedBox(
                height: size.height*0.01,
              ),
              Container(
                padding: EdgeInsets.only(right: 35, left: 50),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Payment Type', textAlign :TextAlign.left)),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Container(
                padding: EdgeInsets.only(right: 35, left: 35),
                child: buildDropdown("Select Payment Type","Cash,Online,Cash On Delivery",PaymentTypeController),
                // ExpansionTile(
                //   initiallyExpanded: false,
                //   maintainState: true,
                //   title: Text('Payment Type',
                //     style: const TextStyle(
                //         fontSize: 16.0,
                //         fontWeight: FontWeight.w400
                //     ),
                //   ),
                //   children: [
                //     SizedBox(
                //       height: size.height*0.01,
                //     ),
                //
                //     SizedBox(
                //       height: size.height*0.01,
                //     ),
                //   ],
                //
                // ),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Container(
                padding: EdgeInsets.only(right: 35, left: 35),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  maintainState: true,
                  title: Text('Delivery Type',
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400
                    ),
                  ),

                  children: [
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Column(
                        children: [
                          buildDropdown("Select Delivery Type","Home Delivery,On-Spot Delivery",DeliveryTypeController),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          Visibility(
                            visible: DeliveryTypeController.text == 'Home Delivery' ?true:false,
                            child: Container(
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                maintainState: true,
                                title: Text('Delivery Details',
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                children: [
                                  Column(
                                      children: [
                                        Container(

                                          padding: EdgeInsets.only(right: 5, left: 5,top: 10,bottom: 10),
                                          child: buildValidationInputField("Contact No.",CustomerEmailController,'','',true,false,Icons.call) ,
                                        ),
                                        // RoundedInputEmailField(hintText: "Customer Email id",
                                        //   onChanged: (value){},
                                        // ),
                                        Container(
                                          padding: EdgeInsets.only(right: 5, left: 5,top: 10,bottom: 10),
                                          child: buildValidationInputField("Name",CustomerNameController,'','',false,false,Icons.person) ,
                                        ),
                                        // RoundedInputNameField(hintText: "Customer Name",
                                        //   onChanged: (value){},
                                        // ),
                                        Container(
                                          padding: EdgeInsets.only(right: 5, left: 5,top: 10,bottom: 10),
                                          child: buildValidationInputField("Building name/House No",CustomerbuildingController,'','',false,false,Icons.home) ,
                                        ),
                                        // RoundedInputAddressField(hintText: "Building name/House No",
                                        //   onChanged: (value){},
                                        // ),
                                        Container(
                                          padding: EdgeInsets.only(right: 5, left: 5,top: 10,bottom: 10),
                                          child: buildValidationInputField("Street No.",CustomerStreetController,'','',false,false,Icons.home) ,
                                        ),
                                        // RoundedInputAddressField(hintText: "Street No.",
                                        //   onChanged: (value){},
                                        // ),
                                        Container(
                                          padding: EdgeInsets.only(right: 5, left: 5,top: 10,bottom: 10),
                                          child: buildValidationInputField("Address 1",Customeraddress1Controller,'','',false,false,Icons.home) ,
                                        ),
                                        // RoundedInputAddressField(hintText: "Address 1",
                                        //   onChanged: (value){},
                                        // ),
                                        Container(
                                          padding: EdgeInsets.only(right: 5, left: 5,top: 10,bottom: 10),
                                          child: buildValidationInputField("Address 2",Customeraddress2Controller,'','',false,false,Icons.home) ,
                                        ),
                                        // RoundedInputAddressField(hintText: "Address 2",
                                        //   onChanged: (value){},
                                        // ),
                                        Container(
                                          padding: EdgeInsets.only(right: 5, left: 5,top: 10,bottom: 10),
                                          child: buildValidationInputField("District",CustomerdistrictController,'','',false,false,Icons.home) ,
                                        ),
                                        // RoundedInputAddressField(hintText: "District",
                                        //   onChanged: (value){},
                                        // ),
                                        Container(
                                          padding: EdgeInsets.only(right: 5, left: 5,top: 10,bottom: 10),
                                          child: buildValidationInputField("State",CustomerstateController,'','',false,false,Icons.home) ,
                                        ),
                                        // RoundedInputAddressField(hintText: "State",
                                        //   onChanged: (value){},
                                        // ),
                                        Container(
                                          padding: EdgeInsets.only(right: 5, left: 5,top: 10,bottom: 10),
                                          child: buildValidationInputField("Pin No.",CustomerPinController,'','',false,false,Icons.home) ,
                                        ),
                                        // RoundedInputAddressField(hintText: "Pin No.",
                                        //   onChanged: (value){},
                                        // ),
                                      ]
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ]
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Container(
                padding: EdgeInsets.only(right: 35, left: 50),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Delivery Date', textAlign :TextAlign.left)),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Container(
                padding: EdgeInsets.only(right: 40, left: 40),
                child: buildDateTime('Delivery Date', DeliverydateController),
              ),
              Visibility(
                visible: registerVisible,
                child: Container(
                    child: Column(
                      children: [
                        const SizedBox(height: defaultPadding),
                        FloatingActionButton.extended(
                          label: Text('Register'), // <-- Text
                          backgroundColor: primaryColor,
                          icon: Icon( // <-- Icon
                            Icons.add,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            List<dynamic> productAllResponseData = [];
                            showDialog(context: context, barrierDismissible: false, builder: (context) {
                              return WillPopScope(
                                onWillPop: () => Future.value(false),
                                child: Center(child: SpinKitFoldingCube(
                                  size: 50,
                                  color: Colors.orange,
                                ),),
                              );
                            });

                            final Map<String, String> NewUserData = {};
                            NewUserData['phone'] = CustomerContactNoController.text;
                            NewUserData['email'] = CustomerEmailController.text;
                            NewUserData['name'] = CustomerNameController.text;
                            NewUserData['building'] = CustomerbuildingController.text;
                            NewUserData['street'] = CustomerStreetController.text;
                            NewUserData['address1'] = Customeraddress1Controller.text;
                            NewUserData['address2'] = Customeraddress2Controller.text;
                            NewUserData['district'] = CustomerdistrictController.text;
                            NewUserData['state'] = CustomerstateController.text;
                            NewUserData['pin'] = CustomerPinController.text;
                            NewUserData['deliveryType'] = DeliveryTypeController.text;
                            NewUserData['paymentType'] = PaymentTypeController.text;
                            NewUserData['deliveryDate'] = DeliverydateController.text;

                            try{
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              String? oxygenToken = pref.getString('oxygen_token');
                              Map<String, dynamic> decodedToken = parseJwtPayLoad(oxygenToken!);

                              bool refresh = refreshRequired(decodedToken["exp"]);

                              if(!refresh){
                                http.Response? new_response;
                                new_response = await http.get(
                                  Uri.parse("http://mibilling.herokuapp.com/product/all"),
                                  headers: {
                                    HttpHeaders.contentTypeHeader: "application/json",
                                    "Authorization": "Bearer $oxygenToken"
                                  },
                                );
                                if (new_response.statusCode == 200) {
                                  // Navigator.of(context).pop();
                                  productAllResponseData = jsonDecode(new_response.body);
                                  showSnackbar('Product Fetched.');

                                }
                                else{
                                  Navigator.of(context).pop();
                                  showSnackbar('Product Fetch : Unexpected Error. Try Again.');
                                }
                              }
                              else{
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                              }
                            }
                            catch(e){
                              Navigator.of(context).pop();
                              showSnackbar('Product Fetch : Unexpected Error Occurred!!');
                            }

                            try{
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              String? oxygenToken = pref.getString('oxygen_token');
                              Map<String, dynamic> decodedToken = parseJwtPayLoad(oxygenToken!);

                              bool refresh = refreshRequired(decodedToken["exp"]);

                              if(!refresh){
                                http.Response? new_response;
                                new_response = await http.post(
                                  Uri.parse("http://mibilling.herokuapp.com/user/register"),
                                  headers: {
                                    HttpHeaders.contentTypeHeader: "application/json",
                                    "Authorization": "Bearer $oxygenToken"
                                  },
                                  body: json.encode({
                                    "email":NewUserData['email'],
                                    "password":"",
                                    "contact":NewUserData['phone'],
                                    "name":NewUserData['name'],
                                    "address1":NewUserData['address1'],
                                    "address2":NewUserData['address2'],
                                    "buildingName":NewUserData['building'],
                                    "streetNo":NewUserData['street'],
                                    "district":NewUserData['district'],
                                    "state":NewUserData['state'],
                                    "pin":NewUserData['pin'],
                                    "storeAddress" : '',
                                  })
                                );
                                if (new_response.statusCode == 200) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Product(newData : NewUserData, productAll : productAllResponseData)));
                                }
                                else{
                                  Navigator.of(context).pop();
                                  showSnackbar('User Register : Unexpected Error. Try Again.');
                                }
                              }
                              else{
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                              }
                            }
                            catch(e){
                              Navigator.of(context).pop();
                              showSnackbar('User Register : Unexpected Error Occurred!!');
                            }

                          },
                        ),
                        SizedBox(
                          height: size.height*0.02,
                        ),
                      ],
                    )
                ),
              ),
              Visibility(
                visible: !registerVisible ,
                child: Container(
                    child: Column(
                      children: [
                        const SizedBox(height: defaultPadding),
                        FloatingActionButton.extended(
                          label: Text('Next'), // <-- Text
                          backgroundColor: primaryColor,
                          icon: Icon( // <-- Icon
                            Icons.keyboard_arrow_right_outlined,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            showDialog(context: context, barrierDismissible: false, builder: (context) {
                              return WillPopScope(
                                onWillPop: () => Future.value(false),
                                child: Center(child: SpinKitFoldingCube(
                                  size: 50,
                                  color: Colors.orange,
                                ),),
                              );
                            });

                            final Map<String, String> NewUserData = {};
                            NewUserData['phone'] = CustomerContactNoController.text;
                            NewUserData['email'] = CustomerEmailController.text;
                            NewUserData['name'] = CustomerNameController.text;
                            NewUserData['building'] = CustomerbuildingController.text;
                            NewUserData['street'] = CustomerStreetController.text;
                            NewUserData['address1'] = Customeraddress1Controller.text;
                            NewUserData['address2'] = Customeraddress2Controller.text;
                            NewUserData['district'] = CustomerdistrictController.text;
                            NewUserData['state'] = CustomerstateController.text;
                            NewUserData['pin'] = CustomerPinController.text;
                            NewUserData['deliveryType'] = DeliveryTypeController.text;
                            NewUserData['paymentType'] = PaymentTypeController.text;
                            NewUserData['deliveryDate'] = DeliverydateController.text;

                            try{
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              String? oxygenToken = pref.getString('oxygen_token');
                              Map<String, dynamic> decodedToken = parseJwtPayLoad(oxygenToken!);

                              bool refresh = refreshRequired(decodedToken["exp"]);

                              if(!refresh){
                                http.Response? new_response;
                                new_response = await http.get(
                                  Uri.parse("http://mibilling.herokuapp.com/product/all"),
                                  headers: {
                                    HttpHeaders.contentTypeHeader: "application/json",
                                    "Authorization": "Bearer $oxygenToken"
                                  },
                                );
                                if (new_response.statusCode == 200) {
                                  final List<dynamic> productAllResponseData = jsonDecode(new_response.body);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Product(newData : NewUserData, productAll : productAllResponseData)));
                                }
                                else{
                                  Navigator.of(context).pop();
                                  showSnackbar('Unexpected Error. Try Again.');
                                }
                              }
                              else{
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                              }
                            }
                            catch(e){
                              Navigator.of(context).pop();
                              showSnackbar('Unexpected Error Occurred!!');
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height*0.03,
                        ),
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );;
  }

  Widget buildDropdown(String labelText, String elementValues, TextEditingController textController) {

    List<String> dropdownItemList = elementValues.split(',');
    String? chosenValue;

    return DropdownButtonFormField(
      value: chosenValue,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: primaryColor,width: 1.0)
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.black,width: 1.0)
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black,width: 1.0),
            borderRadius: BorderRadius.circular(30.0)
        ),
        labelText: labelText,
        labelStyle : TextStyle(color: Colors.black),
      ),
      iconEnabledColor: primaryColor,
      icon: const Icon(Icons.expand_more_outlined),
      iconSize: 18,
      isExpanded: false,
      onChanged: (value) async {
        setState(() {
          chosenValue = value.toString();
          textController.text = chosenValue.toString();
          // widget.finalJsonResponse?[labelText.toLowerCase().camelCase] = value.toString();
        });
      },
      items: dropdownItemList.map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      )).toList(),
    );
  }

  Widget buildValidationInputField(String labelText, TextEditingController textController, String? prefixText, String? suffixText, bool numericKeyboard, bool readOnly,IconData icons){
    bool BlankError = false;
    return TextFormField(
      controller: textController,
      readOnly: readOnly,
      onChanged: (value){
        setState(() {
          BlankError = false;
          typingInputValue = value == '' || value == null ? value : prefixText! + value + suffixText!;
        });
      },
      keyboardType: numericKeyboard ? TextInputType.number : TextInputType.text,
      inputFormatters: numericKeyboard ? <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ] : null,

      decoration: InputDecoration(
        prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,

          child: Icon(icons,color: primaryColor,),
        ),
        suffixIcon: null,
        filled: true,
        labelStyle: TextStyle(color: Colors.black),
        labelText: labelText,
        prefixText: !readOnly ? prefixText : null,
        suffixText: !readOnly ? suffixText : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: primaryColor,width: 0.0),
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: primaryColor,width: 1.0),
        ),
      ),
      style: TextStyle(color: Colors.black),
      validator: (String? value) {
        if (value == null || value == '') {
          return 'Enter $labelText';
        }
        return null;
      },
      autovalidateMode: BlankError ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
    );
  }

  Widget suggestInputField(String labelText, TextEditingController textController, IconData icons, AllUserData) {

    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: null,
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
          // textController.text = value;
          // print(textController.text.toString());
          setState(() {
            CustomerEmailController.text = '';
            CustomerNameController.text = '';
            CustomerbuildingController.text = '';
            CustomerStreetController.text = '';
            Customeraddress1Controller.text = '';
            Customeraddress2Controller.text = '';
            CustomerdistrictController.text = '';
            CustomerstateController.text = '';
            CustomerPinController.text = '';
            registerVisible = true;
          });
        },
        textInputAction : TextInputAction.next,
        // onChanged: (value){
        //   textController.text = value;
        //   print(textController.text.toString());
        // },
      ),
      suggestionsCallback: (pattern) async {
        return await getSuggestions(pattern);
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
        Map userOtherDetails = AllUserData[textController.text.toString()];
        // print('--------------------------------');
        // print(AllUserData);
        // print(userOtherDetails);
        // print('--------------------------------');
        setState(() {
          CustomerEmailController.text = userOtherDetails['email'];
          CustomerNameController.text = userOtherDetails['name'];
          CustomerbuildingController.text = userOtherDetails['buildingName'];
          CustomerStreetController.text = userOtherDetails['streetNo'];
          Customeraddress1Controller.text = userOtherDetails['address1'];
          Customeraddress2Controller.text = userOtherDetails['address2'];
          CustomerdistrictController.text = userOtherDetails['district'];
          CustomerstateController.text = userOtherDetails['state'];
          CustomerPinController.text = userOtherDetails['pin'];
          registerVisible = false;
        });


      },
    );
  }

  Widget buildDateTime(String labelText, TextEditingController textController){
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    return TextFormField(
      readOnly: true,
      controller: textController,
      decoration: InputDecoration(
        prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,

          child: Icon(Icons.calendar_month_sharp,color: primaryColor,),
        ),
        filled: true,
        suffixIcon: Icon(Icons.calendar_today_rounded),
        labelStyle: TextStyle(color: Colors.black),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: primaryColor,width: 0.0),
        ),
        errorText: null,
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: primaryColor,width: 1.0),
        ),
      ),
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: todaysDate,
            firstDate: DateTime(2010),
            lastDate: DateTime(2100)
        );
        if (newDate == null) {
          return ;
        }
        else {
          setState(() {
            todaysDate = newDate;
            textController?.value = TextEditingValue(text: dateFormat.format(newDate));

          });
        }
      },

    );
  }

  List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(userPhone);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  showSnackbar(String snackBarText, {bool showMargin = true}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(snackBarText),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xE62DA2B1),
      margin: showMargin ? const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0) : null,
    ));
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