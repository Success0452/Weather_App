import 'package:flutter/material.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:foodcourt/util/dimensions.dart';

class ContainerWidget extends StatelessWidget {
  final Widget widget;
  final AssetImage image;
  final double width;
  final double height;
  final Color? borderColor;

  const ContainerWidget(
      {Key? key,
      required this.widget,
      required this.image,
      required this.width,
      required this.height,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          image: DecorationImage(image: image, fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          border: Border.all(
            color: borderColor ?? AppColors.transparant,
            width: 1,
          )),
      child: widget,
    );
  }
}
