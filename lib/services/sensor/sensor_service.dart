import 'package:flutter/cupertino.dart';

abstract class SensorService extends ChangeNotifier {
  late double _ph;
  late double _salinity;
  late int _moisture;

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

  Future<void> init();
}
