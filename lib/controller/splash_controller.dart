import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../routes/route.dart';

class SplashController extends ChangeNotifier {
  var loadState = ValueNotifier(false);

  loadingSplash() async {
    loadState.value = true;
    await Future.delayed(const Duration(milliseconds: 5000));

    if (GetStorage().read("onboard") == "viewed") {
      Get.offAllNamed(RouteHelper.getHomePage());
      loadState.value = false;
    } else {
      Get.offAllNamed(RouteHelper.getOnboardingPage());

      loadState.value = false;
    }
  }
}
