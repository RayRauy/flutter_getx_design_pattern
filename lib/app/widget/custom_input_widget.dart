import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {
  String? hintText, label;
  TextEditingController? controller;
  bool obscureText;
  Widget? suffixIcon;
  CustomInputWidget({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: Colors.black54),
          ),
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: Colors.black54),
          ),
          hintText: hintText ?? "",
          label: Text(label ?? ""),

        ),
      ),
    );
  }
}
