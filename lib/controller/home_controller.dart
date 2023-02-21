import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:foodcourt/controller/local_controller.dart';
import 'package:foodcourt/model/cities_model.dart';
import 'package:foodcourt/model/latandlng_model.dart';
import 'package:foodcourt/model/weather_model.dart';
import 'package:foodcourt/routes/http_routes.dart';
import 'package:foodcourt/services/server.dart';
import 'package:foodcourt/util/constant.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends ChangeNotifier {
  var searchWord = TextEditingController();

  // variables to monitor currentAddress and currentPosition
  var currentAddress = ValueNotifier('');
  Position? currentPosition;

  // variable to monitor loading bar
  var loadState = ValueNotifier(false);
  var exceptionState = ValueNotifier(false);

  // list variables
  WeatherModel? weatherInformation;
  List<LatLngModel>? latandlngInformation;
  List<CitiesModel>? citiesModel;
  List searchList = [];
  List<CitiesModel>? staticCites;
  var tracking = [];

  List<Map<String, dynamic>> cities = [
    {"cityName": "Lagos"},
    {"cityName": "Asaba"},
    {"cityName": "Lafia"},
    {"cityName": "Sokoto"},
    {"cityName": "Minna"},
    {"cityName": "Lokoja"},
    {"cityName": "Ondo"},
    {"cityName": "Offa"},
    {"cityName": "Ikeja"},
    {"cityName": "Abuja"},
    {"cityName": "Kano"},
    {"cityName": "Zaria"},
    {"cityName": "Ado-Ekiti"},
    {"cityName": "Lokoja"},
    {"cityName": "Ibadan"},
  ];

  searchUsers() {
    searchList.clear();
    debugPrint(cities.toString());
    searchList = cities
        .where((element) =>
            element['cityName'].toString().startsWith(searchWord.text))
        .toList();
    searchList = cities
        .where((element) => element['cityName']
            .toString()
            .toLowerCase()
            .startsWith(searchWord.text))
        .toList();
    debugPrint(searchList.length.toString());
    notifyListeners();
  }

  clearSearch() {
    searchWord.text = '';
    searchList.clear();
    notifyListeners();
  }

  checkItemWithIndex(String cityName) {
    for (int i = 0; i < cities.length; i++) {
      if (cities[i]['cityName'].toString() ==
          cityName.toString().removeAllWhitespace) {
        GetStorage().write('index', i);
      }
    }
  }

  Future<void> insertItem(String cityName) async {
    for (int i = 0; i < cities.length; i++) {
      if (cities[i]['cityName'] == cityName) {
        var request = CitiesModel(
            cityName: cityName,
            cloud: cities[i]['cloud'],
            humidity: cities[i]['humidity'],
            lat: cities[i]['lat'],
            lng: cities[i]['lng'],
            pressure: cities[i]['pressure'],
            temp: cities[i]['temp'],
            weather: cities[i]['weather']);
        LocalController().addCities(request);
      }
    }
  }

  Future<void> insertStaticItem() async {
    staticCites = [
      CitiesModel(
          cityName: cities[0]['cityName'],
          cloud: cities[0]['cloud'],
          humidity: cities[0]['humidity'],
          lat: cities[0]['lat'],
          lng: cities[0]['lng'],
          pressure: cities[0]['pressure'],
          temp: cities[0]['temp'],
          weather: cities[0]['weather'],
          index: 0),
      CitiesModel(
          cityName: cities[14]['cityName'],
          cloud: cities[14]['cloud'],
          humidity: cities[14]['humidity'],
          lat: cities[14]['lat'],
          lng: cities[14]['lng'],
          pressure: cities[14]['pressure'],
          temp: cities[14]['temp'],
          weather: cities[14]['weather'],
          index: 14),
      CitiesModel(
          cityName: cities[9]['cityName'],
          cloud: cities[9]['cloud'],
          humidity: cities[9]['humidity'],
          lat: cities[9]['lat'],
          lng: cities[9]['lng'],
          pressure: cities[9]['pressure'],
          temp: cities[9]['temp'],
          weather: cities[9]['weather'],
          index: 9)
    ];
  }

  // function to handle location permission
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          'info', 'Location services are disabled. Please enable the services',
          duration: const Duration(milliseconds: 1500));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('info', 'Location permissions are denied',
            duration: const Duration(milliseconds: 1500));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('info',
          'Location permissions are permanently denied, we cannot request permissions.',
          duration: const Duration(milliseconds: 1500));
      return false;
    }
    return true;
  }

  // function to retrieve lat and lng of a location
  Future<void> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();

      if (!hasPermission) return;
      loadState.value = true;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        currentPosition = position;

        getAddressFromLatLng(currentPosition!);
      }).catchError((e) {
        loadState.value = false;
      });
    } on TimeoutException catch (_) {
      Get.snackbar('info', _.message!,
          duration: const Duration(milliseconds: 1500));
      exceptionState.value = true;
      loadState.value = true;
    } on SocketException catch (_) {
      Get.snackbar('info', _.message,
          duration: const Duration(milliseconds: 1500));
      exceptionState.value = true;
      loadState.value = false;
    }
    notifyListeners();
  }

  // function to retrieve address from provided lat and lng
  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      debugPrint(place.locality);
      currentAddress.value =
          '${place.street}, ${place.subLocality}, ${place.locality}';

      for (var index = 0; index < cities.length; index++) {
        getWeatherConditionWithName(
            cities[index]['cityName'].toString(), index);
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // function to get the details of weather condition using latitutud and longitiude
  Future<void> getWeatherConditionWithLatLng(
      double lat, double lng, int index) async {
    var response = await Server.get(HttpRoutes.currentWeaherWithCordinates,
        '?lat=$lat&lon=$lng&appid=${Constant.apiKey}');

    var decoded = json.decode(response);
    cities[index].addAll({
      "weather": decoded['weather'][0]['description'].toString(),
      "temp": decoded['main']['temp'].toString(),
      "humidity": decoded['main']['humidity'].toString(),
      "pressure": decoded['main']['pressure'].toString(),
      "cloud": decoded['clouds']['all'].toString(),
      "lat": lat.toString(),
      "lng": lng.toString(),
    });
    tracking.add(response);
    citiesModel = cities.map((data) => CitiesModel.fromJson(data)).toList();
    if (cities.length == tracking.length) {
      loadState.value = false;
    }
    debugPrint('cities ${cities.toString()}');
    notifyListeners();
  }

  // function to get the details of weather condition using city name
  Future<void> getWeatherConditionWithName(String cityName, int index) async {
    var response = await Server.get(HttpRoutes.currentWeatherWithName,
        '?q=$cityName&limit=1&appid=${Constant.apiKey}');
    List<LatLngModel> latLngModel = (json.decode(response) as List)
        .map((data) => LatLngModel.fromJson(data))
        .toList();
    getWeatherConditionWithLatLng(double.parse(latLngModel[0].lat.toString()),
        double.parse(latLngModel[0].lon.toString()), index);
    // debugPrint('weather-condition $response');
    debugPrint(response);
    notifyListeners();
  }
}
