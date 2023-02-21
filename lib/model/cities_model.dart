import 'package:hive_flutter/adapters.dart';
part 'cities_model.g.dart';

@HiveType(typeId: 0)
class CitiesModel extends HiveObject {
  @HiveField(0)
  String? cityName;
  @HiveField(1)
  String? lat;
  @HiveField(2)
  String? lng;
  @HiveField(3)
  String? weather;
  @HiveField(4)
  String? temp;
  @HiveField(5)
  String? humidity;
  @HiveField(6)
  String? pressure;
  @HiveField(7)
  String? cloud;
  int? index;

  CitiesModel(
      {this.cityName,
      this.lat,
      this.lng,
      this.weather,
      this.temp,
      this.humidity,
      this.pressure,
      this.cloud,
      this.index});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    weather = json['weather'];
    temp = json['temp'];
    humidity = json['humidity'];
    pressure = json['pressure'];
    cloud = json['cloud'];
    lat = json['lat'];
    lng = json['lng'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cityName'] = cityName;
    data['lat'] = lat;
    data['lng'] = lng;
    data['weather'] = weather;
    data['temp'] = temp;
    data['humidity'] = humidity;
    data['pressure'] = pressure;
    data['cloud'] = cloud;
    data['index'] = index;
    return data;
  }
}
