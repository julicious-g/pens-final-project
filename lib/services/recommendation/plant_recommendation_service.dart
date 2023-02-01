import 'package:final_project/models/attributes.dart';
import 'package:final_project/services/sensor/sensor_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../models/plant.dart';

class PlantRecommendationService {
  Map<String, Plant> _plantMap = <String, Plant>{};
  final Map<String, Function> _sensorCheckFunctions = <String, Function>{};

  late SensorService _sensorService;

  PlantRecommendationService() {
    _sensorService = GetIt.instance<SensorService>();

    _sensorCheckFunctions["ph"] = _ispHMatch;
    _sensorCheckFunctions["salinity"] = _isSalinityMatch;
    _sensorCheckFunctions["temperature"] = _isSalinityMatch;
  }

  List<String> plantIds() => _plantMap.entries.map((e) => e.key).toList();

  Plant plant(String key) => _plantMap[key]!;

  Listenable listenable() => _sensorService;

  List<String> plantIdsOrderedByProperties() {
    var plantList = _plantMap.values.toList();

    plantList.sort((b, a) => getTotalFeasibilitiesImportance(a).compareTo(getTotalFeasibilitiesImportance(b)));
    return plantList.map((e) => e.id).toList();
  }

  Future<PlantRecommendationService> init() async {
    var plants = await Plant.fromFile();
    _plantMap = {for (var p in plants) p.id: p};
    return this;
  }

  bool isFeasible(double value, FeasibilityPerformance feasibilityPerformance) {
    return value >= feasibilityPerformance.min &&
        value <= feasibilityPerformance.max;
  }

  @protected
  double getTotalFeasibilitiesImportance(Plant plant) {
    var sensorPhValue = _sensorService.getSensorValue(PlantAttribute.ph) ?? 0;
    var sensorMoistureValue =
        _sensorService.getSensorValue(PlantAttribute.moisture) ?? 0;
    var sensorTemperatureValue =
        _sensorService.getSensorValue(PlantAttribute.temperature) ?? 0;

    return getFeasibilityImportance(plant.ph, sensorPhValue) +
        getFeasibilityImportance(plant.moisture, sensorMoistureValue) +
        getFeasibilityImportance(plant.temperature, sensorTemperatureValue);
  }

  @protected
  double getFeasibilityImportance(
      FeasibilityClass feasibilityClass, double sensorValue) {
    if (isFeasible(sensorValue, feasibilityClass.s1)) {
      return 3;
    } else if (isFeasible(sensorValue, feasibilityClass.s2)) {
      return 2;
    } else if (isFeasible(sensorValue, feasibilityClass.s3)) {
      return 1;
    }
    return 0;
  }

  @protected
  String getFeasibilityLevel(
      double sensorValue, FeasibilityClass feasibilityClass) {
    if (isFeasible(sensorValue, feasibilityClass.s1)) {
      return "S1";
    } else if (isFeasible(sensorValue, feasibilityClass.s2)) {
      return "S2";
    } else if (isFeasible(sensorValue, feasibilityClass.s3)) {
      return "S3";
    }

    return "N";
  }

  String phFeasibilityLevel(Plant plant) {
    var sensorValue = _sensorService.getSensorValue(PlantAttribute.ph) ?? 0;

    return getFeasibilityLevel(sensorValue, plant.ph);
  }

  String moistureFeasibilityLevel(Plant plant) {
    var sensorValue =
        _sensorService.getSensorValue(PlantAttribute.moisture) ?? 0;
    return getFeasibilityLevel(sensorValue, plant.moisture);
  }

  String temperatureFeasibilityLevel(Plant plant) {
    var sensorValue =
        _sensorService.getSensorValue(PlantAttribute.temperature) ?? 0;
    return getFeasibilityLevel(sensorValue, plant.temperature);
  }

  int matchedCount(String plantId) {
    var plant = this.plant(plantId);
    var matchCount = 0;
    _sensorCheckFunctions.forEach((key, value) =>
        matchCount = value(plant) ? matchCount + 1 : matchCount);

    return matchCount;
  }

  bool isMatchAll(Plant plant) {
    var ret = true;

    _sensorCheckFunctions.forEach((key, value) => ret = ret && value(plant));

    return ret;
  }

  bool isMatch(String sensor, Plant plant) {
    var func = _sensorCheckFunctions[sensor] ?? (Plant plant) => false;
    return func(plant);
  }

  bool _ispHMatch(Plant plant) {
    var sensorPh = _sensorService.getSensorValue(PlantAttribute.ph) ?? 0;

    return sensorPh <= plant.maxPh && sensorPh >= plant.minPh;
  }

  bool _isTemperatureMatch(Plant plant) {
    return false;
  }

  bool _isMoistureMatch(Plant plant) {
    return false;
  }

  bool _isSalinityMatch(Plant plant) {
    var sensorSalinity = 0;

    return sensorSalinity <= plant.salinity;
  }
}
