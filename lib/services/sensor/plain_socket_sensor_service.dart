import 'dart:convert';
import 'dart:io';
import 'package:final_project/models/sensors_model.dart';
import 'package:final_project/services/sensor/sensor_service.dart';

class PlainSocketSensorService extends SensorService {
  late Socket _socket;
  late SensorsModel _model;

  @override
  Future<SensorService> init() async {
    _socket = await Socket.connect("localhost", 12345);
    _socket.listen(_dataHandler, onError: _errorHandler, onDone: _doneHandler);

    _model = SensorsModel();
    _model.ph = "-1";

    _socket.write("test");

    return this;
  }

  void _dataHandler(data) {
    var decoded = utf8.decode(data);
    var json = jsonDecode(decoded);
    _model.ph = json["ph"];
    print(_model);
  }

  void _errorHandler(error, StackTrace trace) {}
  void _doneHandler() {
    _socket.destroy();
  }
}
