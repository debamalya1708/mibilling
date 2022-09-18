import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mibilling/Screens/Login/Login.dart';
import 'package:mibilling/Screens/allOrder/allOrder.dart';
import 'package:mibilling/Screens/draft/draft.dart';
import 'package:mibilling/Screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  final int selectedIndex;
  const NavBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar>{
  String appVersion = "";
  int? _selectedDestination;

  List<dynamic> orderAllResponseData = [];

  @override
  void initState() {
    super.initState();
    _selectedDestination = widget.selectedIndex;
    // PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    //   setState(() {
    //     appVersion = packageInfo.version;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;


    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("  Xiaomi"),
            accountEmail: Text("  Xiaomi.India@miindia.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent.withOpacity(0.05),
              child: ClipOval(
                child: Image.asset('assets/images/login.png'),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/signup_top.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0),
            child: ListTile(
              leading: _selectedDestination == 0 ? const Icon(Icons.home_filled) : const Icon(Icons.home_outlined),
              selectedTileColor: Colors.blue.withOpacity(0.15),
              minLeadingWidth: 10,
              title: const Text('Home', style: TextStyle(fontSize: 15),),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              selected: _selectedDestination == 0,
              onTap: () => selectDestination(0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0),
            child: ListTile(
              leading: _selectedDestination == 1 ? const Icon(Icons.account_circle) : const Icon(Icons.account_circle_outlined),
              selectedTileColor: Colors.blue.withOpacity(0.15),
              minLeadingWidth: 10,
              title: const Text('Profile', style: TextStyle(fontSize: 15),),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              selected: _selectedDestination == 1,
              onTap: () => selectDestination(1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0),
            child: ListTile(
              leading: _selectedDestination == 2 ? const Icon(Icons.shopping_cart_rounded) : const Icon(Icons.shopping_cart_outlined),
              selectedTileColor: Colors.blue.withOpacity(0.15),
              minLeadingWidth: 10,
              title: const Text('Orders', style: TextStyle(fontSize: 15),),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              selected: _selectedDestination == 2,
              onTap: () {
                selectDestination(2);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0),
            child: ListTile(
              leading: _selectedDestination == 3 ? const Icon(Icons.drafts,) : const Icon(Icons.drafts_outlined),
              selectedTileColor: Colors.blue.withOpacity(0.15),
              minLeadingWidth: 10,
              title: const Text('Drafts', style: TextStyle(fontSize: 15),),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              selected: _selectedDestination == 3,
              onTap: () => selectDestination(3),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0),
            child: ListTile(
              leading: _selectedDestination == 4 ? const Icon(Icons.settings,) : const Icon(Icons.settings_outlined),
              selectedTileColor: Colors.blue.withOpacity(0.15),
              minLeadingWidth: 10,
              title: const Text('Settings', style: TextStyle(fontSize: 15),),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              selected: _selectedDestination == 4,
              onTap: () => selectDestination(4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0),
            child: ListTile(
              leading: _selectedDestination == 5 ? const Icon(Icons.logout_rounded,) : const Icon(Icons.logout_outlined),
              selectedTileColor: Colors.blue.withOpacity(0.15),
              minLeadingWidth: 10,
              title: const Text('Logout', style: TextStyle(fontSize: 15),),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              selected: _selectedDestination == 5,
              onTap: () => selectDestination(5),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectDestination(int index) async {

    if (_selectedDestination != index) {
      Navigator.pop(context);
      if (index == 0) {
        Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
      }
      else if (index == 1) {
        // Navigator.pop(context);
        if (_selectedDestination == 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Profile()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Profile()));
        }
      }
      else if (index == 2) {

        if (_selectedDestination == 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AllOrder()));
        }
        else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AllOrder()));
        }
      }
      else if (index == 3) {
        // Navigator.pop(context);
        if (_selectedDestination == 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Draft()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Draft()));
        }
      }

      else if (index == 4) {
        // Navigator.pop(context);
        if (_selectedDestination == 0) {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()));
        } else {
          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Settings()));
        }
      }

      else if (index == 5) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23)),
            contentPadding: const EdgeInsets.fromLTRB(23, 18, 23, 3),
            // EdgeInsets.symmetric(vertical: 18, horizontal: 23),
            title: const Center(child: Text('Logout?')),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              // FlatButton(
              //   textColor: Colors.redAccent.withOpacity(0.9),
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   child: Text('CANCEL'),
              // ),
              // FlatButton(
              //   textColor: Colors.green,
              //   onPressed: () async {
              //     SharedPreferences pref = await SharedPreferences.getInstance();
              //     String? oxygenToken = pref.getString('oxygen_token');
              //     http.Response? response;
              //     var connectivityResult = await (Connectivity().checkConnectivity());
              //     if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
              //
              //       response = await http.post(
              //         Uri.parse("http://44.201.49.10:5000/api/v1/logout"),
              //         headers: {
              //           HttpHeaders.contentTypeHeader: "application/json",
              //           "Version": appVersion,
              //           "api_key" : "3b6cb6285b6792841510",
              //           "Authorization": "Bearer $oxygenToken"
              //         },
              //       );
              //
              //       if (response.statusCode == 201){
              //         pref.remove('oxygen_token');
              //         while(Navigator.canPop(context)){
              //           Navigator.pop(context);
              //         }
              //         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
              //       }
              //       else{
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(
              //             content: Text('Unexpected Error! Try again after sometime!'),
              //           ),
              //         );
              //       }
              //     }
              //
              //     else{
              //       showDialog(context: context, builder: (context) {
              //         return AlertDialog(
              //           backgroundColor: Colors.white,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(23)
              //           ),
              //           contentPadding: const EdgeInsets.fromLTRB(23, 18, 23, 3),
              //           // EdgeInsets.symmetric(vertical: 18, horizontal: 23),
              //           title: const Center(child: Text('No Internet!!')),
              //           content: const Text('Logging out will result to unsafe logout!'),
              //           actions: [
              //             FlatButton(
              //               textColor: Colors.redAccent.withOpacity(0.9),
              //               onPressed: () {
              //                 Navigator.pop(context);
              //               },
              //               child: const Text('CANCEL'),
              //             ),
              //             FlatButton(
              //               textColor: Colors.green,
              //               onPressed: () {
              //                 Navigator.pop(context);
              //                 pref.remove('oxygen_token');
              //                 while(Navigator.canPop(context)){
              //                   Navigator.pop(context);
              //                 }
              //                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
              //               },
              //               child: const Text('LOGOUT'),
              //             ),
              //           ],
              //         );
              //       });
              //     }
              //
              //   },
              //   child: const Text('ACCEPT'),
              // ),
            ],
          );
        });

      }
    }
    else{
      Navigator.pop(context);
    }

    setState(() {
      _selectedDestination = index;
    });
  }

}

