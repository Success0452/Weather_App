import 'package:flutter/material.dart';
import 'package:foodcourt/controller/home_controller.dart';
import 'package:foodcourt/routes/route.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:foodcourt/util/dimensions.dart';
import 'package:foodcourt/widgets/big_text.dart';
import 'package:foodcourt/widgets/container_widget.dart';
import 'package:foodcourt/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeMainPage extends StatelessWidget {
  final HomeController value;
  const HomeMainPage({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    // listview that display the number of item passed
    return ValueListenableBuilder(
        valueListenable: value.exceptionState,
        builder: (context, ref, child) {
          return ref == false
              ? SizedBox(
                  height: Dimensions.screenHeight / 1.5,
                  child: Builder(builder: (context) {
                    return ListView.builder(
                        itemCount: value.searchList.isEmpty
                            ? value.cities.length
                            : value.searchList.length,
                        itemBuilder: (context, index) {
                          // contianer that display each item
                          return Padding(
                            padding: EdgeInsets.only(
                                top: Dimensions.height10,
                                bottom: Dimensions.height10),
                            child: GestureDetector(
                              onTap: (() {
                                value.searchList.isEmpty
                                    ? GetStorage().write("index", index)
                                    : value.checkItemWithIndex(
                                        value.searchList[index]['cityName']);
                                Get.toNamed(RouteHelper.getDetailsPage(),
                                    arguments: {'current': false});
                              }),
                              child: ContainerWidget(
                                  widget: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                BigText(
                                                  text: value
                                                          .searchList.isNotEmpty
                                                      ? value.searchList[index]
                                                          ['cityName']
                                                      : value
                                                          .citiesModel![index]
                                                          .cityName!,
                                                  size: Dimensions.font26,
                                                  color: AppColors.white,
                                                ),
                                                const SmallText(
                                                  text: 'Location',
                                                  color: AppColors.white,
                                                )
                                              ],
                                            ),
                                            BigText(
                                              text: value.searchList.isNotEmpty
                                                  ? '${value.searchList[index]['temp']} \u2103'
                                                  : '${value.citiesModel![index].temp} \u2103',
                                              size: Dimensions.font26,
                                              color: AppColors.white,
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text: value
                                                  .citiesModel![index].weather!,
                                              color: AppColors.white,
                                            ),
                                            SmallText(
                                              text: value.searchList.isNotEmpty
                                                  ? 'H ${value.searchList[index]['temp']} \u2103 L:${value.searchList[index]['temp'].toString()} \u2103'
                                                  : 'H:${value.citiesModel![index].humidity} \u2103 L:${value.cities[index]['pressure'].toString()} \u2103',
                                              color: AppColors.white,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  image: AssetImage(value
                                              .citiesModel![index].weather! ==
                                          "haze"
                                      ? 'assets/images/tree-sunlight-bg.jpg'
                                      : value.citiesModel![index].weather! ==
                                              "scattered clouds"
                                          ? 'assets/images/thunderbolt-lighting-bg.png'
                                          : value.citiesModel![index]
                                                      .weather! ==
                                                  "clear sky"
                                              ? 'assets/images/cloudy_bg.jpg'
                                              : value.citiesModel![index]
                                                          .weather! ==
                                                      "broken clouds"
                                                  ? 'assets/images/thunderstorm2-bg.jpg'
                                                  : value.citiesModel![index]
                                                              .weather! ==
                                                          "few clouds"
                                                      ? 'assets/images/thunderstorm-bg.jpg'
                                                      : 'assets/images/cloudy_bg.jpg'),
                                  width: Dimensions.screenWidth,
                                  height: Dimensions.height40 * 3),
                            ),
                          );
                        });
                  }),
                )
              : SizedBox(
                  height: Dimensions.screenHeight / 1.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmallText(
                        text: "Timed out",
                        color: AppColors.grey,
                      ),
                      SmallText(
                          text: "pull to refresh", color: AppColors.lightBlue)
                    ],
                  ),
                );
        });
  }
}
