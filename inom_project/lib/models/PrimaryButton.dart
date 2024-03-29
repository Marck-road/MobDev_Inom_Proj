import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        backgroundColor: const Color(0xFFce4257),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: const Color(0xFFf9dbbd),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17.0,
                color: Color(0xFFf9dbbd),
              ),
            ),
          )
        ],
      ),
    );
  }
}
