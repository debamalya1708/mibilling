
import 'dart:ui';

import "package:flutter/material.dart";

import '../../../constants.dart';
import '../../UserSearch/UserSearch.dart';
import 'background.dart';
import 'roundedInputField.dart';
import 'roundedPasswordField.dart';


class Body extends StatelessWidget{

  const Body({
    Key? key,
  }):super(key: key);

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          // Text("LOGIN"
          // ,style: TextStyle(fontWeight: FontWeight.bold),
          // ),
          SizedBox(
            height: size.height*0.1,
          ),
          Image.asset("assets/images/login.png",height: size.height *0.1,),
          SizedBox(
            height: size.height*0.1,
          ),
          RoundedInputField(hintText: "Enter MI Id",
          onChanged: (value){},
          ),
          RoundPasswordContainer(
            onChanged: (value){},
          ),
          const SizedBox(height: defaultPadding),
          FloatingActionButton.extended(
            label: Text('Log In'), // <-- Text
            backgroundColor: primaryColor,
            icon: Icon( // <-- Icon
              Icons.login,
              size: 24.0,
            ),
            onPressed: () {Navigator.push(
              context,MaterialPageRoute(
              builder: (context){
                return UserSearch();
                },
            ),
            );
              },
          ),
        ],
      ),
    );
    // );
  }

}


// class RoundPasswordContainer extends StatelessWidget {
//   final ValueChanged<String> onChanged;
//   const RoundPasswordContainer({
//     Key? key,
//     required this.onChanged,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(child: TextField(
//       onChanged: onChanged,
//       obscureText: true,
//       decoration : InputDecoration(
//       hintText: "Password",
//       icon: Icon(
//         Icons.lock,
//         color: primaryColor,
//       ),
//       suffixIcon: Icon(Icons.visibility,color: primaryColor,
//       ),
//       border: InputBorder.none,
//     ),
//     ),
//     );
//   }
// }

// class RoundedInputField extends StatelessWidget {
//   final String hintText;
//   final IconData icon;
//   final ValueChanged<String> onChanged;
//   const RoundedInputField({
//     Key? key,
//     required this.hintText,
//     this.icon = Icons.person,
//     required this.onChanged,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(
//       child: TextField(
//         onChanged: onChanged,
//       decoration: InputDecoration(
//         icon: Icon(icon, color: primaryColor,),
//         hintText: hintText,
//         border: InputBorder.none,
//       ),
//     ),
//     );
//   }
// }

// class TextFieldContainer extends StatelessWidget {
//   final Widget child;
//   const TextFieldContainer({
//     Key? key, required this.child,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
//       width: size.width*0.8,
//       decoration: BoxDecoration(
//         color: primaryLightColor,
//         borderRadius: BorderRadius.circular(29),
//       ),
//       child:child,
//     );
//   }
// }

// class Background extends StatelessWidget {
//   final Widget child;
//   const Background({
//     Key? key,
//     required this.child,
//   }) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: double.infinity,
//       height: size.height,
//       child: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[Positioned(
//           top: 0,
//           left: 0,
//           child: Image.asset(
//             "assets/images/main_top.png",
//             width: size.width*0.35,
//           ),
//         ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: Image.asset(
//                 "assets/images/login_bottom.png"),
//             width: size.width*0.4,
//           ),
//           child,
//         ],
//       ),
//     );
//   }
// }