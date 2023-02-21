import 'package:flutter/material.dart';
import 'package:foodcourt/controller/home_controller.dart';
import 'package:foodcourt/controller/local_controller.dart';
import 'package:foodcourt/model/cities_model.dart';
import 'package:foodcourt/util/colors.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'controller/splash_controller.dart';
import 'routes/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CitiesModelAdapter());
  await Hive.openBox<CitiesModel>("cities");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => LocalController())
      ],
      child: GetMaterialApp(
        theme: ThemeData(
            bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: AppColors.primaryColor)),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteHelper.getInitialPage(),
        getPages: RouteHelper.routes,
      ),
    );
  }
}
