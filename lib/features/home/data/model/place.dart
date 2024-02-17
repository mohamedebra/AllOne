import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Place {
  late Result result;

  Place.fromJson(dynamic json) {
    result = Result.fromJson(json['result']);
  }
}

class Result {
  late Geometry geometry;

  Result.fromJson(dynamic json) {
    geometry = Geometry.fromJson(json['geometry']);
  }
}

class Geometry {
  late Location location;

  Geometry.fromJson(dynamic json) {
    location = Location.fromJson(json['location']);
  }
}
class Location {
  double? lat;
  double? lng;

  Location({this.lat,this.lng});

   Location.fromJson(json);
}

List<Location> locationTest =[
  Location(),
  Location(),
];


class PlaceSuggestion {
   String? placeId;
   String? description;

   PlaceSuggestion({this.placeId,this.description});
}

List<PlaceSuggestion> placeSuggestion =[
  PlaceSuggestion(
      description: 'mansoura',
      placeId: ''
  ),
];


class PlaceDirections{
  LatLngBounds bounds;
  List<PointLatLng> polylinePoints;
  String totalDistance;
  String totalDuration;

  PlaceDirections({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });
}

List<PlaceDirections> placeDirections = [

];
