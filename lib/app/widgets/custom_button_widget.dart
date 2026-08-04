import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  String? label;
  bool? loading;
  VoidCallback? onclick;
  CustomButtonWidget({super.key, this.label, this.loading, this.onclick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      
        child: loading == true
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Text(
                label ?? "",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
