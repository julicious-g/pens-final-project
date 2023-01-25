import 'dart:collection';

import 'package:flutter/material.dart';

abstract class SensorService extends ChangeNotifier {
  final Map<String, double> _sensorValues = {};

  @protected
  void setSensorValue(String sensorName, double value) {
    _sensorValues[sensorName] = value;
  }

  double? getSensorValue(String sensorName) {
    return _sensorValues[sensorName];
  }

  Future<SensorService> init();
}
