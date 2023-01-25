import 'package:final_project/services/sensor/sensor_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/attributes.dart';

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
        _cardPh(),
        _cardTemperature(),
        Expanded(
            child: Card(
          child: Center(
            child: ListTile(
              leading: const Icon(Icons.water_drop),
              title: AnimatedBuilder(
                  animation: _sensorService,
                  builder: (context, child) {
                    return Text(
                      "${_sensorService.getSensorValue(PlantAttribute.moisture)!.round()} %",
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

  Widget _cardPh() {
    return Expanded(
        child: Card(
      child: Center(
        child: ListTile(
          leading: const Icon(Icons.science),
          title: AnimatedBuilder(
            animation: _sensorService,
            builder: (context, child) {
              return Text(
                  _sensorService
                      .getSensorValue(PlantAttribute.ph)!
                      .toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold));
            },
          ),
          subtitle: const Text("pH"),
        ),
      ),
      elevation: 10,
    ));
  }

  Widget _cardTemperature() {
    return Expanded(
        child: Card(
      child: Center(
        child: ListTile(
          leading: const Icon(Icons.thermostat),
          title: AnimatedBuilder(
            animation: _sensorService,
            builder: (context, child) {
              return Text(
                  _sensorService
                      .getSensorValue(PlantAttribute.temperature)!
                      .toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold));
            },
          ),
          subtitle: const Text("Celcius"),
        ),
      ),
      elevation: 10,
    ));
  }
}
