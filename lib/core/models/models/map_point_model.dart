
import '../entities/map_point_entity.dart';

class MapPointModel extends MapPointEntity {
  const MapPointModel({required super.latitude, required super.longitude});

  factory MapPointModel.fromJson(Map<String, dynamic> json) {
    return MapPointModel(latitude: json['lat'], longitude: json['long']);
  }
}
