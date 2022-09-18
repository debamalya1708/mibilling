import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/Login/Login.dart';
import 'Screens/UserRegistration/registration.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();}

class _MyAppState extends State<MyApp> {

  var loggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'MI BILLER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2661FA),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }

  // getLoggedInValidationData() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return pref.getBool('loggedIn');
  // }

}
