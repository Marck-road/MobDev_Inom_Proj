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
    return TextFormField(
      readOnly: true,
      initialValue: value,
      decoration: InputDecoration(
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Icon(iconData),
        ),
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
