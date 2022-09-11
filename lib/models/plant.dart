import 'dart:convert';
import 'package:flutter/services.dart';

class Plant {
  late String name;
  late String latinName;
  late String minPh;
  late String maxPh;
  late String minMoisture;
  late String maxMoisture;
  late String minTemperature;
  late String maxTemperature;
  late String salinity;

  Plant(
      {required this.name,
      required this.latinName,
      required this.minPh,
      required this.maxPh,
      required this.minMoisture,
      required this.maxMoisture,
      required this.minTemperature,
      required this.maxTemperature,
      required this.salinity});

  static List<Plant> _cache = List.empty();

  static Future<List<Plant>> fromFile() async {
    if (_cache.isNotEmpty) {
      return _cache;
    }

    var json = await rootBundle.loadString("data/plant.json");
    List decodedJson = jsonDecode(json);
    _cache = decodedJson.map((e) => Plant.fromJson(e)).toList();
    // await Future.delayed(const Duration(seconds: 3));
    return _cache;
  }

  Plant.fromJson(Map<String, dynamic> plant) {
    name = plant["name"];
    latinName = plant["latinName"];
    minPh = plant["minPh"];
    maxPh = plant["maxPh"];
    minMoisture = plant["minMoisture"];
    maxMoisture = plant["maxMoisture"];
    minTemperature = plant["minTemperature"];
    maxTemperature = plant["maxTemperature"];
    salinity = plant["salinity"];
  }
}
