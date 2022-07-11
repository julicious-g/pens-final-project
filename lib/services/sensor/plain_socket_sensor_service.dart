import 'dart:io';
import 'package:final_project/services/sensor/sensor_service.dart';

class PlainSocketSensorService extends SensorService {
  late Socket _socket;

  @override
  Future<void> init() async {
    _socket = await Socket.connect("host", 9999);
    _socket.listen(_dataHandler, onError: _errorHandler, onDone: _doneHandler);
  }

  void _dataHandler(data) {}
  void _errorHandler(error, StackTrace trace) {}
  void _doneHandler() {
    _socket.destroy();
  }
}
