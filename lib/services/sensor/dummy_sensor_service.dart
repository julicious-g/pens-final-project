import 'dart:async';
import 'dart:math';
import 'package:final_project/services/sensor/sensor_service.dart';
import 'package:final_project/models/sensors_model.dart';

class DummySensorService extends SensorService {
  @override
  Future<SensorService> init() async {
    _randomizeSensorValue();
    return this;
  }

  void _randomizeSensorValue() {
    var seed = DateTime.now().millisecondsSinceEpoch;
    var ph = Random(seed).nextDouble() + Random(seed).nextInt(14);
    var salinity = Random(seed).nextDouble() + Random(seed).nextInt(5);
    var moisture = Random(seed).nextInt(100);
    var temperature = Random(seed).nextInt(9) + 20;

    setPh(ph);
    setSalinity(salinity);
    setMoisture(moisture);
    setTemperature(temperature.toDouble());
    notifyListeners();

    // Timer(const Duration(seconds: 2), _randomizeSensorValue);
  }
}
