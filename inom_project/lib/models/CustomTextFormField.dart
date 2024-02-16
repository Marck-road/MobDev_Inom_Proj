import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.iconData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFefe9e7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Color(0xFF4f000b)),
          hintStyle: const TextStyle(color: Color(0xFF4f000b)),
          prefixIconColor: Color(0xFF4f000b),
          prefixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(iconData),
          ),
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}
