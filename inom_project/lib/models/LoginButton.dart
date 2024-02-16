import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final String? uniqueIcon;
  final IconData? iconData;
  final VoidCallback onPressed;
  final double textSize;

  const LoginButton({
    super.key,
    this.uniqueIcon,
    required this.text,
    required this.iconData,
    required this.onPressed,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        backgroundColor: const Color(0xFFce4257),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null)
            Icon(
              iconData,
              color: const Color(0xFF4f000b),
              size: 24,
            ),
          if (uniqueIcon != null)
            SvgPicture.asset(
              uniqueIcon!,
              height: 17,
            ),
          const SizedBox(
            width: 0.0,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textSize,
                color: const Color(0xFFefe9e7),
              ),
            ),
          )
        ],
      ),
    );
  }
}
