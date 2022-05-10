import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.labelText}) : super(key: key);
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              color: kBorderColor,
              width: 1.2,
            ),
          ),
          labelText: labelText,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
