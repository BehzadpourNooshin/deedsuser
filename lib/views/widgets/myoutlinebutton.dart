import 'package:deedsuser/utils/constant.dart';
import 'package:flutter/material.dart';

class MyOutlineButton extends StatelessWidget {
  const MyOutlineButton(
      {super.key,
      required this.title,
      required this.myicon,
      required this.iconcolor,
      required this.bordercolor,
      required this.function,
      required this.mystyle});

  final String title;
  final IconData myicon;
  final Color iconcolor;
  final Color bordercolor;
  final Function() function;
  final TextStyle mystyle;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title, style: mystyle),
            Icon(
              myicon,
              color: iconcolor,
            )
          ],
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: kCardColor,
          shadowColor: bordercolor,
          elevation: 5,
          side: BorderSide(
            width: 5.0,
            color: bordercolor,
            style: BorderStyle.solid,
          ),
        ));
  }
}
