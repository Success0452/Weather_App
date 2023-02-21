import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/dimensions.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  final FontWeight? fontWeight;
  final TextOverflow overflow;

  const BigText({
    Key? key,
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.size = 0,
    this.fontWeight,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 1,
        overflow: overflow,
        style: GoogleFonts.roboto(
            color: color,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontSize: size == 0 ? Dimensions.font20 : size));
  }
}
