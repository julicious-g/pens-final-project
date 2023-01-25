import 'dart:convert';
import 'package:flutter/services.dart';

class Plant {
  late String id;
  late String name;
  late String latinName;
  late double minPh;
  late double maxPh;
  late double minMoisture;
  late double maxMoisture;
  late double minTemperature;
  late double maxTemperature;
  late double salinity;
  late dynamic ph;
  late dynamic temperature;
  late dynamic moisture;
  late Map<String, dynamic> attributes;

  Plant.empty();

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

    var json = await rootBundle.loadString("./assets/data/plant.json");
    List decodedJson = jsonDecode(json);
    _cache = decodedJson.map((e) => Plant.fromJson(e)).toList();
    // await Future.delayed(const Duration(seconds: 3));
    return _cache;
  }

  Plant.fromJson(Map<String, dynamic> plant) {
    id = plant["id"];
    name = plant["name"];
    latinName = plant["latinName"];
    minPh = double.parse(plant["minPh"].toString());
    maxPh = double.parse(plant["maxPh"].toString());
    minMoisture = double.parse(plant["minMoisture"].toString());
    maxMoisture = double.parse(plant["maxMoisture"].toString());
    minTemperature = double.parse(plant["minTemperature"].toString());
    maxTemperature = double.parse(plant["maxTemperature"].toString());
    salinity = double.parse(plant["salinity"].toString());

    attributes = {};

    attributes["ph"] = plant["ph"];
    attributes["temperature"] = plant["temperature"];
    attributes["moisture"] = plant["moisture"];

    ph = plant["ph"];
    temperature = plant["temperature"];
    moisture = plant["moisture"];
  }
}
