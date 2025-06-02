import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        border: OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'برجاْ ملء الحقل';
        } else if (labelText == "العنوان") {
          if (value.length < 10) {
            return 'ادخل عنوان صحيح';
          }
        } else if (labelText == "رقم الهاتف") {
          if (value.length < 11) {
            return "ادخل رقم صحيح";
          }
        } else if (labelText == "الاسم رباعي") {
          if (value.length < 4) {
            return "ادخل اسم صحيح";
          }
        } else if (labelText == "الرقم القومي") {
          if (value.length < 14) {
            return "ادخل رقم صحيح";
          }
        } else if (labelText == "الرقم التسلسلي") {
          if (!(value is int)) {
            return "ادخل رقم ";
          }
        } else if (labelText == "الكليه") {
          return "awaiting finishing a list of colleges";
        }
        return null;
      },
    );
  }
}
