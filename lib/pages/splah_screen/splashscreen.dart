import 'package:flutter/material.dart';
import 'package:foodcourt/controller/home_controller.dart';
import 'package:foodcourt/controller/splash_controller.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:foodcourt/util/dimensions.dart';
import 'package:foodcourt/widgets/big_text.dart';
import 'package:foodcourt/widgets/small_text.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // marks the first function to be called
  @override
  void initState() {
    // initialize the loadingSplash function declared in the splash_controller
    context.read<SplashController>().loadingSplash();
    context.read<HomeController>().getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // implementation of app logo on splash screen
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/cloudsunright.png",
                height: 100,
                width: 300,
              ),
            ],
          ),

          // loading progress bar implementation
          SizedBox(
            width: Dimensions.width40,
            height: Dimensions.height20,
            child: const CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 3,
            ),
          ),

          // first text implementation
          Padding(
            padding: EdgeInsets.only(top: Dimensions.height10),
            child: BigText(
              text: "Weather",
              size: Dimensions.font20,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          // second text implementation
          SmallText(
            text: "Forecast",
            size: Dimensions.font15,
            color: AppColors.grey,
          )
        ],
      ),
    );
  }
}
