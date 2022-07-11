import 'package:flutter/material.dart';

abstract class SensorService {
  late double _ph;
  late double _soilMoisture;
  late double _airTemp;
  late double _airMoisture;

  SensorService() {
    _ph = 0.0;
    _soilMoisture = 0.0;
    _airTemp = 0.0;
    _airMoisture = 0.0;
  }

  Future<void> init();

  double getPh() => _ph;
  double getSoilMoisture() => _soilMoisture;
  double getAirTemp() => _airTemp;
  double getAirMoisture() => _airMoisture;
}
