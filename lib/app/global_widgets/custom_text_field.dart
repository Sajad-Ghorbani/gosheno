import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.showError = false,
    this.height = 45,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.minLines = 1,
    this.autofocus = false,
    this.textAlign = TextAlign.center,
    this.keyboardType = TextInputType.text,
    this.toolbarOptions,
    this.onTap,
    this.inputFormatters,
    this.enabled,
  }) : super(key: key);
  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool showError;
  final double? height;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int maxLines;
  final int minLines;
  final bool autofocus;
  final bool? enabled;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final ToolbarOptions? toolbarOptions;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          labelText: labelText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        validator: validator,
        toolbarOptions: toolbarOptions,
        textAlign: textAlign,
        onChanged: onChanged,
        obscureText: obscureText,
        minLines: minLines,
        maxLines: maxLines,
        autofocus: autofocus,
        keyboardType: keyboardType,
        onTap: onTap,
        inputFormatters: inputFormatters,
        enabled: enabled,
      ),
    );
  }
}
