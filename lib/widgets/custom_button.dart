import 'package:flutter/material.dart';
import 'package:foodcourt/util/dimensions.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final GestureTapCallback? pressed;
  final double width;
  final double height;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.color,
      this.pressed,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius30)),
          ),
          onPressed: pressed,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimensions.font15,
            ),
          )),
    );
  }
}
