import 'package:flutter/material.dart';
import 'package:foodcourt/controller/home_controller.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:foodcourt/util/dimensions.dart';
import 'package:foodcourt/widgets/big_text.dart';
import 'package:foodcourt/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailsMainPage extends StatefulWidget {
  final bool? cancel;
  final int index;
  final bool? current;
  const DetailsMainPage(
      {super.key, this.cancel, required this.index, this.current});

  @override
  State<DetailsMainPage> createState() => _DetailsMainPageState();
}

class _DetailsMainPageState extends State<DetailsMainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, value, child) {
        return Padding(
          padding: EdgeInsets.only(bottom: Dimensions.height20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.height20 * 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.location_searching,
                        size: Dimensions.icon24,
                        color: Colors.yellow,
                      ),
                      Text(
                        widget.current!
                            ? value.currentDetails!.cityName!
                            : value.cities[widget.index]['cityName'].toString(),
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: Dimensions.font26 * 1.3,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      ButtonWidget(
                        text: widget.current!
                            ? value.currentDetails!.weather!
                            : value.cities[widget.index]['weather'].toString(),
                        color: Colors.yellow[800]!,
                        width: Dimensions.width40 * 12,
                        height: Dimensions.height40 * 1.3,
                        pressed: () {},
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Text(
                        widget.current!
                            ? '${value.currentDetails!.temp!} \u2103'
                            : '${value.cities[widget.index]['temp'].toString()} \u2103',
                        style: GoogleFonts.mulish(
                            color: AppColors.white,
                            fontSize: Dimensions.font26 * 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Text(
                        widget.current!
                            ? value.currentDetails!.weather!
                            : value.cities[widget.index]['weather'].toString(),
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: Dimensions.font26,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      ButtonWidget(
                        text: widget.current!
                            ? value.currentDetails!.cityName!
                            : value.cities[widget.index]['cityName'].toString(),
                        color: Colors.yellow[800]!,
                        width: Dimensions.width40 * 12,
                        height: Dimensions.height40 * 1.3,
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Dimensions.height20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: Dimensions.width25,
                            ),
                            Icon(
                              Icons.thunderstorm_outlined,
                              size: Dimensions.icon24,
                              color: AppColors.white,
                            ),
                            SizedBox(
                              width: Dimensions.width15,
                            ),
                            Text(
                              "Today  Cloudy",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Dimensions.font15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.width25),
                          child: Text(
                            widget.current!
                                ? value.currentDetails!.cloud!
                                : value.cities[widget.index]['cloud']
                                    .toString(),
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: Dimensions.font15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Dimensions.height20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: Dimensions.width25,
                            ),
                            Icon(
                              Icons.thunderstorm_outlined,
                              size: Dimensions.icon24,
                              color: AppColors.white,
                            ),
                            SizedBox(
                              width: Dimensions.width15,
                            ),
                            Text(
                              "Today  Humidity",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Dimensions.font15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.width25),
                          child: Text(
                            widget.current!
                                ? '${value.currentDetails!.humidity!} \u2103'
                                : "${value.cities[widget.index]['humidity'].toString()} \u2103",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: Dimensions.font15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Dimensions.height20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: Dimensions.width25,
                            ),
                            Icon(
                              Icons.thunderstorm_outlined,
                              size: Dimensions.icon24,
                              color: AppColors.white,
                            ),
                            SizedBox(
                              width: Dimensions.width15,
                            ),
                            Text(
                              "Pressure",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Dimensions.font15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.width25),
                          child: Text(
                            widget.current!
                                ? 'P: ${value.currentDetails!.humidity!} \u2103'
                                : 'P: ${value.cities[widget.index]['pressure'].toString()} \u2103',
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: Dimensions.font15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height15,
                  ),
                  ButtonWidget(
                    text: "Forecast",
                    color: Colors.yellow[800]!,
                    width: Dimensions.width40 * 12,
                    height: Dimensions.height40 * 1.3,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
