import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  final double height;
  final bool underline;

  const SmallText(
      {Key? key,
      required this.text,
      this.color = const Color(0xFFccc7c5),
      this.size = 12,
      this.height = 1.2,
      this.underline = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
          fontSize: size,
          height: height,
          decoration:
              underline ? TextDecoration.underline : TextDecoration.none),
    );
  }
}
