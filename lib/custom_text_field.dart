import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType textInputType;
  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        autofocus: false,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
