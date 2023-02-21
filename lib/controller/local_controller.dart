import 'package:flutter/material.dart';
import 'package:foodcourt/model/cities_model.dart';
import 'package:foodcourt/services/hive_service.dart';

class LocalController extends ChangeNotifier {
  List<CitiesModel>? _savedCites;
  List<CitiesModel> get savedCites => _savedCites!;
  var hiveService = HiveService();

  Future<void> addCities(CitiesModel cities) async {
    CitiesModel citiesModel = CitiesModel(
        cityName: cities.cityName,
        humidity: cities.humidity,
        lat: cities.lat,
        lng: cities.lng,
        pressure: cities.pressure,
        temp: cities.temp,
        cloud: cities.cloud,
        weather: cities.weather);
    hiveService.createItem(citiesModel);
    readCities();
    notifyListeners();
  }

  Future<void> readCities() async {
    _savedCites = hiveService.getAllItem();
  }

  Future<void> deleteCities(String cityName) async {
    hiveService.deleteItem(cityName);
    notifyListeners();
  }
}
