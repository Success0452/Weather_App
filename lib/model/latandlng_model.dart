class LatLngModel {
  String? name;
  LocalNames? localNames;
  double? lat;
  double? lon;
  String? country;
  String? state;

  LatLngModel(
      {this.name,
      this.localNames,
      this.lat,
      this.lon,
      this.country,
      this.state});

  LatLngModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localNames = json['local_names'] != null
        ? LocalNames.fromJson(json['local_names'])
        : null;
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    if (localNames != null) {
      data['local_names'] = localNames!.toJson();
    }
    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}

class LocalNames {
  String? en;
  String? ru;

  LocalNames({this.en, this.ru});

  LocalNames.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ru = json['ru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['en'] = en;
    data['ru'] = ru;
    return data;
  }
}
