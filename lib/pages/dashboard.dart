import 'package:final_project/services/sensor/sensor_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Dashboard extends StatelessWidget {
  late SensorService _sensorService;
  Dashboard() {
    _sensorService = GetIt.instance<SensorService>();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Expanded(
            child: Card(
          child: Center(
            child: ListTile(
              leading: const Icon(Icons.science),
              title: AnimatedBuilder(
                animation: _sensorService.PH,
                builder: (context, child) {
                  return Text(_sensorService.PH.value.toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold));
                },
              ),
              subtitle: const Text("pH"),
            ),
          ),
          elevation: 10,
        )),
        Expanded(
            child: Card(
          child: Center(
            child: ListTile(
              leading: const Icon(Icons.bolt),
              title: AnimatedBuilder(
                  animation: _sensorService.Salinity,
                  builder: (context, child) {
                    return Text(
                      "${_sensorService.Salinity.value.toStringAsFixed(2)} dS/cm",
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    );
                  }),
              subtitle: const Text("Salinity"),
            ),
          ),
          elevation: 10,
        )),
        Expanded(
            child: Card(
          child: Center(
            child: ListTile(
              leading: const Icon(Icons.water_drop),
              title: AnimatedBuilder(
                  animation: _sensorService.Moisture,
                  builder: (context, child) {
                    return Text(
                      "${_sensorService.Moisture.value} %",
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    );
                  }),
              subtitle: const Text("Moisture"),
            ),
          ),
          elevation: 10,
        ))
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    ));
  }
}
