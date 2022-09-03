import 'dart:async';
import 'dart:math';

import 'package:final_project/services/sensor/sensor_service.dart';
import 'package:final_project/models/sensors_model.dart';

class DummySensorService extends SensorService {
  late SensorsModel _sensorValue;

  @override
  Future<SensorService> init() async {
    _randomizeSensorValue();
    return this;
  }

  void _randomizeSensorValue() {
    var seed = DateTime.now().millisecondsSinceEpoch;
    PH.value = Random(seed).nextDouble() + Random(seed).nextInt(14);
    Salinity.value = Random(seed).nextDouble() + Random(seed).nextInt(5);
    Moisture.value = Random(seed).nextInt(100);

    Timer(const Duration(seconds: 2), _randomizeSensorValue);
  }
}
