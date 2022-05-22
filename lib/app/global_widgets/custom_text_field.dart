import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.showError = false,
    this.height = 45,
  }) : super(key: key);
  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool showError;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border:  const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          labelText: labelText,
        ),
        validator: validator,
        textAlign: TextAlign.center,
      ),
    );
  }
}
