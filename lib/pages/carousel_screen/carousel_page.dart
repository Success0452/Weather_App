import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodcourt/controller/home_controller.dart';
import 'package:foodcourt/model/cities_model.dart';
import 'package:foodcourt/pages/details_screen/details_main_page.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:foodcourt/util/dimensions.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({super.key});

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  int index = GetStorage().read('index');
  List<CitiesModel>? storageList;

  @override
  void initState() {
    context.read<HomeController>().insertStaticItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: SafeArea(child: Consumer<HomeController>(
        builder: (context, value, child) {
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: Dimensions.height10),
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: Dimensions.height40 * 17,
                      enableInfiniteScroll: false),
                  items: value.staticCites!.asMap().keys.toList().map((index) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.height5),
                            decoration: const BoxDecoration(
                                color: AppColors.primaryColor),
                            child: DetailsMainPage(
                                cancel: true,
                                index: value.staticCites![index].index!));
                      },
                    );
                  }).toList(),
                ),
              )
            ],
          );
        },
      )),
    );
  }
}
