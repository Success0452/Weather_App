// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CitiesModelAdapter extends TypeAdapter<CitiesModel> {
  @override
  final int typeId = 0;

  @override
  CitiesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CitiesModel(
      cityName: fields[0] as String?,
      lat: fields[1] as String?,
      lng: fields[2] as String?,
      weather: fields[3] as String?,
      temp: fields[4] as String?,
      humidity: fields[5] as String?,
      pressure: fields[6] as String?,
      cloud: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CitiesModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lng)
      ..writeByte(3)
      ..write(obj.weather)
      ..writeByte(4)
      ..write(obj.temp)
      ..writeByte(5)
      ..write(obj.humidity)
      ..writeByte(6)
      ..write(obj.pressure)
      ..writeByte(7)
      ..write(obj.cloud);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CitiesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
