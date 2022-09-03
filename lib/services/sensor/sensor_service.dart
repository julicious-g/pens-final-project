import 'package:flutter/cupertino.dart';

abstract class SensorService {
  late ValueNotifier<double> PH = ValueNotifier<double>(0.0);
  late ValueNotifier<double> Salinity = ValueNotifier<double>(0.0);
  late ValueNotifier<int> Moisture = ValueNotifier<int>(0);

  SensorService() {}

  Future<void> init();
}
