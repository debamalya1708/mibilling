import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../../components/background.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mibilling/Screens/UserRegistration/registration.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Login extends StatefulWidget {

  Login({Key? key,}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();

}


class _LoginState extends State<Login>{

  late String typingInputValue;
  Map<String, TextEditingController> billInfoData = {};
  var CustomerMiIDController = TextEditingController();
  var CustomerPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // typingInputValue = '';
    // var textControl =  new TextEditingController(text: 'Dummy');
    // billInfoData.putIfAbsent('CustomerContactNo'.toString(), () => textControl);
  }

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                height: size.height*0.0,
              ),
              Image.asset("assets/images/login.png",height: size.height *0.1,),
              SizedBox(
                height: size.height*0.05,
              ),
              Container(
                child: Text("Log In",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,),
                ),
              ),
              SizedBox(
                height: size.height*0.05,
              ),
              Container(
                padding: EdgeInsets.only(right: 40, left: 40),
                child: buildValidationInputField("MI Id",CustomerMiIDController,'','',false,true,false,Icons.person) ,

              ),
              SizedBox(
                height: size.height*0.03,
              ),
              Container(
                padding: EdgeInsets.only(right: 40, left: 40),
                child: buildValidationInputField("Password",CustomerPasswordController,'','',true,false,false,Icons.lock) ,

              ),
              const SizedBox(height: defaultPadding),
              FloatingActionButton.extended(
                label: Text('Log In'), // <-- Text
                backgroundColor: primaryColor,
                icon: Icon( // <-- Icon
                  Icons.login,
                  size: 24.0,
                ),
                onPressed: () async {
                  if (CustomerMiIDController.text.isNotEmpty && CustomerPasswordController.text.isNotEmpty) {
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
                      http.Response? response;
                      response = await http.post(
                          Uri.parse("http://mibilling.herokuapp.com/user/login"),
                          headers: {
                            HttpHeaders.contentTypeHeader: "application/json",
                            // "Version": appVersion,
                            // "api_key" : apiKey
                          },
                          body: json.encode({
                            "userName": CustomerMiIDController.text,
                            "password": CustomerPasswordController.text
                          })
                      );

                      if (response.statusCode == 200) {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        final loginResponseData = jsonDecode(response.body);
                        pref.setString('oxygen_token', loginResponseData['response']);

                        String? oxygenToken = pref.getString('oxygen_token');
                        Map<String, dynamic> decodedToken = parseJwtPayLoad(oxygenToken!);

                        bool refresh = refreshRequired(decodedToken["exp"]);

                        if(!refresh){
                          http.Response? new_response;
                          new_response = await http.get(
                            Uri.parse("http://mibilling.herokuapp.com/user/all"),
                            headers: {
                              HttpHeaders.contentTypeHeader: "application/json",
                              "Authorization": "Bearer $oxygenToken"
                            },
                          );
                          if (new_response.statusCode == 200) {
                            final userAllResponseData = jsonDecode(new_response.body);
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserRegistration(Alluserdata: userAllResponseData)));
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
                      else {
                        Navigator.of(context).pop();
                        showSnackbar('Invalid credentials');
                      }
                    }
                    catch(e){
                      Navigator.of(context).pop();
                      showSnackbar('Unexpected Error Occurred!!');
                    }

                  }
                  else {
                    if (CustomerMiIDController.text.isEmpty && CustomerPasswordController.text.isEmpty) {
                      showSnackbar("Username and password is empty!");
                    }
                    else if (CustomerMiIDController.text.isEmpty) {
                      showSnackbar("Username is empty!");
                    }
                    else {
                      CustomerPasswordController.text = '';
                      showSnackbar("Password is empty!");
                    }
                  }
                },
              ),
            ],
          ),
        )
    );


    // );
  }



  Widget buildValidationInputField(String labelText, TextEditingController textController,String? prefixText, String? suffixText,bool passwordField, bool numericKeyboard, bool readOnly,IconData icons){
    bool BlankError = false;
    return TextFormField(
      controller: textController,
      readOnly: readOnly,
      obscureText: passwordField,
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