import 'dart:convert';
import 'package:flutter/services.dart';

class FeasibilityPerformance {
  late double min;
  late double max;
  late double importance;

  FeasibilityPerformance({required this.min, required this.max});

  FeasibilityPerformance.fromJson(Map<String, dynamic> json, this.importance) {
    min = json["min"];
    max = json["max"];
  }
}

class FeasibilityClass {
  late final bool ready;
  late final FeasibilityPerformance s1;
  late final FeasibilityPerformance s2;
  late final FeasibilityPerformance s3;

  FeasibilityClass({required this.s1, required this.s2, required this.s3});

  FeasibilityClass.fromJson(Map<String, dynamic> json) {
    ready = json["ready"] ?? false;
    s1 = FeasibilityPerformance.fromJson(json["s1"], 3);
    s2 = FeasibilityPerformance.fromJson(json["s2"], 2);
    s3 = FeasibilityPerformance.fromJson(json["s3"], 1);
  }
}

class Plant {
  late String id;
  late String name;
  late String latinName;
  late FeasibilityClass ph;
  late FeasibilityClass temperature;
  late FeasibilityClass moisture;
  // late Map<String, dynamic> attributes;

  Plant.empty();

  Plant({
    required this.name,
    required this.latinName,
  });

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
    ph = FeasibilityClass.fromJson(plant["ph"]);
    moisture = FeasibilityClass.fromJson(plant["moisture"]);
    temperature = FeasibilityClass.fromJson(plant["temperature"]);
  }
}
