import 'package:deedsuser/functions/converttopersiannumbers.dart';
import 'package:flutter/material.dart';

class PersianText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  // ignore: use_key_in_widget_constructors
  const PersianText(this.text,
      {this.style,
      TextAlign? textAlign,
      TextOverflow? overflow,
      TextDirection? textDirection});

  @override
  Widget build(BuildContext context) {
    return Text(
      convertToPersianNumbers(text), // تبدیل اعداد به فارسی
      style: style,
    );
  }
}
