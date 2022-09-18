import 'package:flutter/material.dart';

import '../navbar/navbar.dart';

class Draft extends StatefulWidget {
  const Draft({Key? key}) : super(key: key);

  @override
  State<Draft> createState() => _DraftState();
}

class _DraftState extends State<Draft> {

  List<String> dummyData = ['Username: Test', 'Email: mi.india@miindia.com', 'Employee Name: MI', 'Employee Type: Mi User', 'Password: ********', 'Mobile No.: 1234567890'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(selectedIndex: 3,),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Draft"),
        // automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: dummyData.length,
          itemBuilder: (context, index) {
            return Card(
                elevation: 2,
                child: ListTile(
                  title: Text(dummyData[index]),
                )
            );
          }),
    );
  }

}
