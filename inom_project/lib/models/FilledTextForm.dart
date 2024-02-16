import 'package:flutter/material.dart';

class FilledTextForm extends StatelessWidget {
  final String labelText;
  final String? value;
  final IconData iconData;

  const FilledTextForm({
    Key? key,
    required this.labelText,
    required this.value,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFefe9e7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        readOnly: true,
        initialValue: value,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Color(0xFF4f000b)),
          hintStyle: const TextStyle(color: Color(0xFF4f000b)),
          prefixIconColor: const Color(0xFF4f000b),
          prefixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(iconData),
          ),
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
