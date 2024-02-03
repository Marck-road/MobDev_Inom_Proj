import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final IconData iconData;
  final VoidCallback onTap;
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    required this.onTap,
    required this.iconData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: "Enter your Password",
          prefixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(iconData),
          ),
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          ),
          labelText: labelText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)))),
    );
  }
}
