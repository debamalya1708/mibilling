import 'package:flutter/material.dart';
import 'package:mibilling/constants.dart';
import '../../constants.dart';
import 'components/searchContainer.dart';
import 'package:flutter/services.dart';

class UserSearch extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Color(0xFFFF6E00)
    // ));
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('MI Billing'),
          backgroundColor: Color(0xFFFF6E00),
        ),
        body: Search(onChanged: (value) {},)
    );
  }
}

class Search extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const Search({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SearchContainer(child: TextField(
          onChanged: onChanged,
          obscureText: true,
          decoration : InputDecoration(
          hintText: "Search User By Phone or Email",
          icon: Icon(
            Icons.search_sharp,
            color: Color(0xFFFF6E00),
          ),
          border: InputBorder.none,
        ),
        ),
        ),
      ],
    );
  }
}