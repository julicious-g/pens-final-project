import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:final_project/models/sensors_model.dart';
import 'package:final_project/services/sensor/sensor_service.dart';

class PlainSocketSensorService extends SensorService {
  static const String MESSAGE_ASKING = "!ASKING";
  static const String MESSAGE_DISCONNECT = "!DISCONNECT";
  static const int HEADER_LENGTH = 64; // bit

  late Socket _socket;
  late SensorsModel _model;

  @override
  Future<SensorService> init() async {
    _socket = await Socket.connect("localhost", 5050);
    _socket.listen(_dataHandler, onError: _errorHandler, onDone: _doneHandler);

    _model = SensorsModel("0", "0");
    _model.ph = "-1";
    _sendMessageEveryNSeconds(1);

    return this;
  }

  @override
  SensorsModel SensorData() {
    return SensorData();
  }

  void _sendMessageEveryNSeconds(int second) {
    var list = List<int>.empty(growable: true);
    var message = MESSAGE_ASKING;
    var message_length_message = utf8.encode(message.length.toString());
    var rest = "";

    while (rest.length < HEADER_LENGTH - message_length_message.length) {
      rest += " ";
    }

    list.addAll(message_length_message);
    list.addAll(utf8.encode(rest));

    _socket.add(message_length_message);
    _socket.add(utf8.encode(message));
  }

  void _dataHandler(data) {
    var decoded = utf8.decode(data);

    print(data);

    var json = jsonDecode(decoded);
    _model.ph = json["ph"];
    print(_model);
  }

  void _errorHandler(error, StackTrace trace) {}
  void _doneHandler() {
    _socket.destroy();
  }
}
