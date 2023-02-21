import 'package:foodcourt/model/cities_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  void createItem(CitiesModel citiesModel) async {
    var cities = Hive.box<CitiesModel>("cities");
    final checkItem = cities.values
        .where((element) => element.cityName == citiesModel.cityName);
    if (checkItem.isEmpty) {
      cities.add(citiesModel);
    } else {
      Get.snackbar('info', "item already present",
          duration: const Duration(milliseconds: 800));
    }
  }

  List<CitiesModel> getAllItem() {
    var cities = Hive.box<CitiesModel>("cities");
    return cities.values.toList();
  }

  CitiesModel? getItem(String? cityName) {
    var cities = Hive.box<CitiesModel>("cities");
    final item = cities.values.where((element) => element.cityName == cityName);
    if (item.isEmpty) {
      return null;
    } else {
      return item.first;
    }
  }

  Future<bool> deleteItem(String cityName) async {
    var cities = Hive.box<CitiesModel>("cities");
    final checkItem =
        cities.values.where((element) => element.cityName == cityName);
    if (checkItem.isEmpty) {
      Get.snackbar('info', "item does not exist",
          duration: const Duration(milliseconds: 800));
      return false;
    } else {
      final deleteItem =
          cities.values.firstWhere((element) => element.cityName == cityName);
      await deleteItem.delete();
      Get.snackbar('info', 'item deleted',
          duration: const Duration(milliseconds: 800));
      return true;
    }
  }

  void updateItem(CitiesModel citiesModel) async {
    var cities = Hive.box<CitiesModel>("cities");
    final updateItem = cities.values
        .firstWhere((element) => element.cityName == citiesModel.cityName);
    final index = updateItem.key as int;
    await cities.put(index, citiesModel);
  }
}
