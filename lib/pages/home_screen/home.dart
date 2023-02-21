import 'package:flutter/material.dart';
import 'package:foodcourt/controller/home_controller.dart';
import 'package:foodcourt/controller/local_controller.dart';
import 'package:foodcourt/pages/home_screen/home_main_page.dart';
import 'package:foodcourt/routes/route.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:foodcourt/util/dimensions.dart';
import 'package:foodcourt/widgets/big_text.dart';
import 'package:foodcourt/widgets/custom_button.dart';
import 'package:foodcourt/widgets/custom_textfield.dart';
import 'package:foodcourt/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<LocalController>().readCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: ((context, value, child) {
        return Scaffold(
          // prevent bottomsheet coming up with the keyboard
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primaryColor,
          body: SafeArea(
              child: RefreshIndicator(
            onRefresh: () {
              // reload the weather details
              return context.read<HomeController>().getCurrentPosition();
            },
            child: ListView(
              padding: EdgeInsets.only(
                  left: Dimensions.width25, right: Dimensions.width25),
              children: [
                // top level item declaration
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.height20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: value.currentAddress,
                          builder: (context, ref, child) {
                            return ref == ''
                                ? SizedBox(
                                    width: Dimensions.width40,
                                    height: Dimensions.height20,
                                    child: const CircularProgressIndicator(
                                      color: AppColors.white,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : SmallText(
                                    text:
                                        'Current Location: ${value.currentAddress.value}',
                                    color: AppColors.white,
                                  );
                          }),

                      // icon to navigate to static page
                      GestureDetector(
                        onTap: (() {
                          Get.toNamed(RouteHelper.getCarouselPage());
                        }),
                        child: const Icon(
                          Icons.more_rounded,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                ),

                // wather text implemented
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.height20),
                      child: BigText(
                        text: "Weather",
                        size: Dimensions.font26 * 1.5,
                        color: AppColors.white,
                      ),
                    ),

                    // button to navigate to current location page
                    ButtonWidget(
                      text: value.currentAddress.value.split(',')[2],
                      color: Colors.yellow[800]!,
                      width: Dimensions.width40 * 5,
                      height: Dimensions.height40,
                      pressed: () {
                        value.checkItemWithIndex(
                            value.currentAddress.value.split(',')[2]);
                        Get.toNamed(RouteHelper.getDetailsPage());
                      },
                    ),
                  ],
                ),

                // textfield to search item
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20, bottom: Dimensions.height20),
                  child: CustomRoundTextField(
                    textCapitalization: TextCapitalization.none,
                    hintText: 'Search for a City',
                    prefixIcon: const Icon(Icons.search_off_outlined),
                    controller: value.searchWord,
                    onChanged: (newValue) {
                      setState(() {
                        value.searchUsers();
                      });
                    },
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            value.searchUsers();
                          });
                        },
                        child: const Icon(Icons.refresh)),
                  ),
                ),

                // main page implementation
                ValueListenableBuilder(
                    valueListenable: value.loadState,
                    builder: (context, ref, child) {
                      return ref
                          ? SizedBox(
                              height: Dimensions.screenHeight / 1.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Dimensions.width40,
                                    height: Dimensions.height20,
                                    child: const CircularProgressIndicator(
                                      color: AppColors.white,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                  const SmallText(text: "pull to refresh")
                                ],
                              ),
                            )
                          : HomeMainPage(value: value);
                    })
              ],
            ),
          )),

          // bottomssheet to display information
          bottomSheet: SizedBox(
            height: Dimensions.height40,
            width: Dimensions.screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallText(
                  text: 'Learn more about weather data and map data',
                  color: AppColors.grey,
                  underline: true,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
