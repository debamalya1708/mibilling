import 'package:flutter/material.dart';
import 'package:mibilling/Screens/Login/components/textContainerField.dart';

import '../../../constants.dart';

class RoundPasswordContainer extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundPasswordContainer({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(child: TextField(
      onChanged: onChanged,
      obscureText: true,
      decoration : InputDecoration(
        hintText: "Password",
        icon: Icon(
          Icons.lock,
          color: primaryColor,
        ),
        suffixIcon: Icon(Icons.visibility,color: primaryColor,
        ),
        border: InputBorder.none,
      ),
    ),
    );
  }
}
