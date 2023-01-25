import 'dart:async';
import 'dart:convert';

import 'package:final_project/models/attributes.dart';
import 'package:final_project/services/sensor/sensor_service.dart';
import 'package:http/http.dart' as Http;

class HttpSensorService extends SensorService {
  static const String _url = '192.168.4.1';
  static const String _path = 'sensor';
  // static const String _url = 'catfact.ninja'; // for testing purpose
  // static const String _path = 'fact'; // for testing purpose

  late Timer timer;

  @override
  Future<SensorService> init() async {
    timer = Timer.periodic(const Duration(seconds: 1), (t) async {
      await _makeHttpRequest();
    });

    setSensorValue(PlantAttribute.ph, 0.0);
    setSensorValue(PlantAttribute.temperature, 0.0);
    setSensorValue(PlantAttribute.moisture, 0.0);

    return this;
  }

  Future<void> _makeHttpRequest() async {
    var url = Uri.http(_url, _path);
    var response = await Http.get(url);

    print('Response status: ${response.statusCode}');
    print("Response body: ${response.body}");

    if (response.statusCode != 200) {
      print("Something wrong when making a request");
      print(response.body);
      return;
    }

    var sensor = jsonDecode(response.body);

    setSensorValue(PlantAttribute.ph, double.parse(sensor["ph"].toString()));
    setSensorValue(PlantAttribute.temperature,
        double.parse(sensor["temperature"].toString()));
    setSensorValue(
        PlantAttribute.moisture, double.parse(sensor["moisture"].toString()));

    notifyListeners();
  }
}
