import 'package:deedsuser/utils/constant.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onPressed;

  const AvatarButton(
      {Key? key,
      required this.text,
      required this.isActive,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: onPressed,
        child: MouseRegion(
          cursor: SystemMouseCursors.click, // تغییر نشانگر موس به شکل دست
          child: CircleAvatar(
            backgroundColor: isActive ? kPrimaryColor : kLightGreyColor,
            child: Text(
              text,
              style: isActive
                  ? TextStyle(color: kCardColor)
                  : TextStyle(color: kPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
