import 'package:flutter/material.dart';

class FilterSearchModel extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final bool isSelected;

  const FilterSearchModel({
    super.key,
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
            activeColor: const Color(0xFFff9b54),
            focusColor: const Color(0xFFf9dbbd),
          ),
          Text(
            widget.text,
            style: const TextStyle(
              color: Color(0xFFf9dbbd),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
