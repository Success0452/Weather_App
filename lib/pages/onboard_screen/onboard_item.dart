import 'package:flutter/material.dart';
import 'package:foodcourt/routes/route.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:foodcourt/util/dimensions.dart';
import 'package:foodcourt/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardItem extends StatelessWidget {
  final String title1;
  final String title2;
  final String backgroundImage;
  const OnboardItem(
      {super.key,
      required this.title1,
      required this.title2,
      required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: Dimensions.screenHeight,
          width: Dimensions.screenWidth,
          decoration: const BoxDecoration(color: AppColors.primaryColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // skip text button implementation
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        GetStorage().write('onboard', 'viewed');
                        Get.offAllNamed(RouteHelper.getHomePage());
                      },
                      child: const SmallText(
                        text: "Skip",
                        color: AppColors.white,
                      ))
                ],
              ),

              // cloud image implementation
              Image.asset(
                backgroundImage,
                height: Dimensions.height40 * 2,
                width: Dimensions.height40 * 2,
              ),

              // implementation of descriptive text about the app
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title1,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          color: AppColors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Text(
                      title2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          color: AppColors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
