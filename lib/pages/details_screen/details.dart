import 'package:flutter/material.dart';
import 'package:foodcourt/controller/local_controller.dart';
import 'package:foodcourt/pages/details_screen/details_main_page.dart';
import 'package:foodcourt/pages/details_screen/details_top_level.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int index = GetStorage().read("index");
  bool current = Get.arguments['current'] ?? false;

  @override
  void initState() {
    context.read<LocalController>().readCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: ListView(
        children: [
          // top level carousel implmentation
          DetailsTopLevel(index: index),

          // main page implementation
          DetailsMainPage(index: index, cancel: false, current: current)
        ],
      )),
    );
  }
}
