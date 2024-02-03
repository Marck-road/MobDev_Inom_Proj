import 'package:flutter/material.dart';

class FilterSearchModel extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final bool isSelected;

  const FilterSearchModel({
    required this.text,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  State<FilterSearchModel> createState() => _FilterSearchModelState();
}

class _FilterSearchModelState extends State<FilterSearchModel> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Radio(
            value: widget.text,
            groupValue: widget.isSelected ? widget.text : null,
            onChanged: (value) {
              widget.onChanged(value as String);
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          Text(widget.text),
        ],
      ),
    );
  }
}
