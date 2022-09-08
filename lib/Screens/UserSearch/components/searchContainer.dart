import "package:flutter/material.dart";

import '../../../constants.dart';

class SearchContainer extends StatelessWidget {
  final Widget child;
  const SearchContainer({
    Key? key, required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      width: size.width*1,
      decoration: BoxDecoration(
        color: primaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child:child,
    );
  }
}
