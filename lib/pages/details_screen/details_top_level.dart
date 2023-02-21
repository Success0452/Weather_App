import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodcourt/controller/home_controller.dart';
import 'package:foodcourt/controller/local_controller.dart';
import 'package:foodcourt/model/cities_model.dart';
import 'package:foodcourt/services/hive_service.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:foodcourt/util/dimensions.dart';
import 'package:foodcourt/widgets/big_text.dart';
import 'package:provider/provider.dart';

class DetailsTopLevel extends StatefulWidget {
  final int index;
  const DetailsTopLevel({super.key, required this.index});

  @override
  State<DetailsTopLevel> createState() => _DetailsTopLevelState();
}

class _DetailsTopLevelState extends State<DetailsTopLevel> {
  List<CitiesModel>? storageList;
  @override
  void initState() {
    context.read<LocalController>().readCities();
    storageList = HiveService().getAllItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: ((context, value, child) {
        return Padding(
            padding: EdgeInsets.only(
                top: Dimensions.height15, bottom: Dimensions.height15),
            child: storageList!.isNotEmpty
                ? CarouselSlider(
                    options: CarouselOptions(
                        height: Dimensions.height40 * 4,
                        enableInfiniteScroll: false),
                    items: storageList!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.height5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(i.weather! == "haze"
                                          ? 'assets/images/tree-sunlight-bg.jpg'
                                          : i.weather! == "scattered clouds"
                                              ? 'assets/images/thunderbolt-lighting-bg.png'
                                              : i.weather! == "clear sky"
                                                  ? 'assets/images/cloudy_bg.jpg'
                                                  : i.weather! ==
                                                          "broken clouds"
                                                      ? 'assets/images/thunderstorm2-bg.jpg'
                                                      : i.weather! ==
                                                              "few clouds"
                                                          ? 'assets/images/thunderstorm-bg.jpg'
                                                          : 'assets/images/cloudy_bg.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Dimensions.height10,
                                            bottom: Dimensions.height10,
                                            right: Dimensions.width10,
                                            left: Dimensions.width10),
                                        child: GestureDetector(
                                          onTap: (() {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return SizedBox(
                                                  height:
                                                      Dimensions.height40 * 10,
                                                  child: ListView.builder(
                                                      itemCount: context
                                                          .read<
                                                              HomeController>()
                                                          .cities
                                                          .length,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        return Container(
                                                            height: Dimensions
                                                                    .height40 *
                                                                1.5,
                                                            width: Dimensions
                                                                .width40,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        Dimensions
                                                                            .radius20)),
                                                            child: Center(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          context
                                                                              .read<HomeController>()
                                                                              .insertItem(context.read<HomeController>().cities[index]['cityName']);
                                                                          var request =
                                                                              CitiesModel(
                                                                            cityName:
                                                                                context.read<HomeController>().cities[index]['cityName'],
                                                                            cloud:
                                                                                context.read<HomeController>().cities[index]['cloud'],
                                                                            humidity:
                                                                                context.read<HomeController>().cities[index]['humidity'],
                                                                            lat:
                                                                                context.read<HomeController>().cities[index]['lat'],
                                                                            lng:
                                                                                context.read<HomeController>().cities[index]['lng'],
                                                                            pressure:
                                                                                context.read<HomeController>().cities[index]['pressure'],
                                                                            temp:
                                                                                context.read<HomeController>().cities[index]['temp'],
                                                                            weather:
                                                                                context.read<HomeController>().cities[index]['weather'],
                                                                          );
                                                                          setState(
                                                                              () {
                                                                            storageList!.add(request);
                                                                          });
                                                                        },
                                                                        child:
                                                                            BigText(
                                                                          text: context
                                                                              .read<HomeController>()
                                                                              .citiesModel![index]
                                                                              .cityName!,
                                                                          color:
                                                                              AppColors.white,
                                                                        ))));
                                                      })),
                                                );
                                              },
                                            );
                                          }),
                                          child: Icon(
                                            Icons.add_circle_outline_outlined,
                                            size: Dimensions.radius20 * 1.2,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Dimensions.height10,
                                            bottom: Dimensions.height10,
                                            right: Dimensions.width10,
                                            left: Dimensions.width10),
                                        child: GestureDetector(
                                          onTap: (() {
                                            context
                                                .read<LocalController>()
                                                .deleteCities(i.cityName!);
                                            Navigator.of(context).pop();
                                            setState(() {
                                              storageList!.removeWhere(
                                                  (element) =>
                                                      element.cityName ==
                                                      i.cityName);
                                            });
                                          }),
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            size: Dimensions.radius20 * 1.2,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  BigText(
                                    text: i.cityName!,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  BigText(
                                    text: '${i.temp!} \u2103',
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  BigText(
                                    text: i.weather!,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ));
                        },
                      );
                    }).toList(),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: Dimensions.height40 * 10,
                              child: ListView.builder(
                                  itemCount: context
                                      .read<HomeController>()
                                      .cities
                                      .length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                        height: Dimensions.height40 * 1.5,
                                        width: Dimensions.width40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20)),
                                        child: Center(
                                            child: TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<HomeController>()
                                                      .insertItem(context
                                                              .read<
                                                                  HomeController>()
                                                              .cities[index]
                                                          ['cityName']);
                                                  var request = CitiesModel(
                                                    cityName: context
                                                        .read<HomeController>()
                                                        .cities[index]['cityName'],
                                                    cloud: context
                                                        .read<HomeController>()
                                                        .cities[index]['cloud'],
                                                    humidity: context
                                                        .read<HomeController>()
                                                        .cities[index]['humidity'],
                                                    lat: context
                                                        .read<HomeController>()
                                                        .cities[index]['lat'],
                                                    lng: context
                                                        .read<HomeController>()
                                                        .cities[index]['lng'],
                                                    pressure: context
                                                        .read<HomeController>()
                                                        .cities[index]['pressure'],
                                                    temp: context
                                                        .read<HomeController>()
                                                        .cities[index]['temp'],
                                                    weather: context
                                                        .read<HomeController>()
                                                        .cities[index]['weather'],
                                                  );
                                                  setState(() {
                                                    storageList!.add(request);
                                                  });
                                                },
                                                child: BigText(
                                                  text: context
                                                      .read<HomeController>()
                                                      .citiesModel![index]
                                                      .cityName!,
                                                  color: AppColors.white,
                                                ))));
                                  })),
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: Dimensions.screenWidth / 1.2,
                            height: Dimensions.height40 * 3,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    width: 1,
                                    color: AppColors.grey)),
                            child: Icon(
                              Icons.add_circle_outline_outlined,
                              size: Dimensions.icon35,
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
      }),
    );
  }
}
