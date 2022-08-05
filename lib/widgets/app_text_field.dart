import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    //required this.onChanged,
    required this.hintText,
    //this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.hintMaxLines,
    this.maxLines,
    this.suffixIcon,
    this.textInputAction,
    this.prefixIcon,
  });
  // final Function(String?) onChanged;
  // final String? Function(String?)? validator;
  final String hintText;
  final int? hintMaxLines;
  final int? maxLines;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      //validator: validator,
      //onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction,
      maxLines: maxLines ?? 1,

      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintMaxLines: hintMaxLines,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.brown,
        ),
        enabledBorder: outlineBorder(),
        focusedBorder: outlineBorder(
          color: Colors.brown,
        ),
        filled: true,
      ),
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF3C3C43),
      ),
    );
  }
}

OutlineInputBorder outlineBorder({Color color = Colors.grey}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Colors.brown,
    ),
    borderRadius: BorderRadius.circular(10),
  );
}
