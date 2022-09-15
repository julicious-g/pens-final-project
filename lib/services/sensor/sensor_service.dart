import 'package:flutter/material.dart';

abstract class SensorService extends ChangeNotifier {
  late double _ph = 0;
  late double _salinity = 0;
  late int _moisture = 0;

  @protected
  void setPh(double ph) {
    _ph = ph;
  }

  @protected
  void setSalinity(double salinity) {
    _salinity = salinity;
  }

  @protected
  void setMoisture(int moisture) {
    _moisture = moisture;
  }

  double getPh() => _ph;
  double getSalinity() => _salinity;
  int getMoisture() => _moisture;

  Future<SensorService> init();
}
