

import 'package:flutter/material.dart';
import 'package:mibilling/Screens/Login/components/body.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body()
    );
  }
}
// class Body extends StatelessWidget{
//
// const Body({
//   Key? key,
// }):super(key: key);
//
//  @override
//  Widget build(BuildContext context){
//    Size size = MediaQuery.of(context).size;
//    return Container(
//           width: double.infinity,
//           height: size.height,
//           child: Stack(
//             alignment: Alignment.center,
//             children: <Widget>[Positioned(
//               top: 0,
//               left: 0,
//               child: Image.asset(
//                 "assets/images/main_top.png",
//               width: size.width*0.35,
//             ),
//             ),
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: Image.asset(
//                     "assets/images/login_bottom.png"),
//                 width: size.width*0.4,
//               )
//             ],
//           ),
//         );
//       // );
//   }
//
// }