import 'dart:collection';

import 'package:flutter/material.dart';

abstract class SensorService extends ChangeNotifier {
  static const int _queueLimit = 100;

  final Queue<double> _phs = Queue<double>();
  final Queue<double> _salinities = Queue<double>();
  final Queue<int> _moistures = Queue<int>();
  final Queue<double> _temperatures = Queue<double>();

  @protected
  void setPh(double ph) {
    _addToQueue(_phs, ph);
  }

  @protected
  void setSalinity(double salinity) {
    _addToQueue(_salinities, salinity);
  }

  @protected
  void setMoisture(int moisture) {
    _addToQueue(_moistures, moisture);
  }

  @protected
  void setTemperature(double temperature) {
    _addToQueue(_temperatures, temperature);
  }

  // all of sensors values are the average of values retrieve from arduino
  double getPh() =>
      _phs.reduce((value, element) => value + element) / _phs.length;
  double getSalinity() =>
      _salinities.reduce((value, element) => value + element) /
      _salinities.length;
  double getTemperature() =>
      _temperatures.reduce((value, element) => value + element) /
      _temperatures.length;
  double getMoisture() =>
      _moistures.reduce((value, element) => value + element) /
      _salinities.length;

  Future<SensorService> init();

  void _addToQueue<T>(Queue<T> list, T value) {
    list.add(value);
    if (list.length > _queueLimit) {
      list.removeFirst();
    }
  }
}
