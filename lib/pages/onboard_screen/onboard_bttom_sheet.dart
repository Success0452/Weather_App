import 'package:flutter/material.dart';
import 'package:foodcourt/routes/route.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:foodcourt/util/dimensions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardBottomSheet extends StatelessWidget {
  final PageController controller;
  final bool isLastPage;
  const OnboardBottomSheet(
      {super.key, required this.controller, required this.isLastPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height40 * 10,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimensions.radius30 * 6),
          )),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: Dimensions.height30),
            child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const ExpandingDotsEffect(
                    dotColor: Colors.black,
                    dotHeight: 10,
                    activeDotColor: Colors.black), // your preferred effect
                onDotClicked: (index) {}),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (isLastPage) {
                    GetStorage().write('onboard', 'viewed');
                    Get.offAllNamed(RouteHelper.getHomePage());
                  } else {
                    controller.nextPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn);
                  }
                },
                child: Container(
                  width: Dimensions.width40 * 3,
                  height: Dimensions.height40 * 3,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    size: Dimensions.font26 * 1.2,
                    color: AppColors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
