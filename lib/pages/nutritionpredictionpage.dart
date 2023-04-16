// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:final_project/models/attributes.dart';
import 'package:final_project/models/nutrition_prediction_model.dart';
import 'package:final_project/services/recommendation/nutrition_prediction_service.dart';
import 'package:final_project/services/sensor/sensor_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NutritionRecommendationPage extends StatelessWidget {
  late SensorService _sensorService;

  NutritionRecommendationPage() {
    _sensorService = GetIt.instance<SensorService>();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sensorService,
      builder: (context, child) {
        var ph = _sensorService.getSensorValue(PlantAttribute.ph) ?? 0;
        var moisture =
            _sensorService.getSensorValue(PlantAttribute.moisture) ?? 0;
        var temperature =
            _sensorService.getSensorValue(PlantAttribute.temperature) ?? 0;
        var cec = NutritionPredictionService.cec(ph);
        var phosporus = NutritionPredictionService.phosporus2(ph, cec.value);
        var pottasium = NutritionPredictionService.pottasium(ph, cec.value);
        var nitrogen =
            NutritionPredictionService.nitrogen(moisture, temperature);

        return Center(
            child: Column(
          children: [
            _nutritionCard(nitrogen),
            _nutritionCard(phosporus),
            _nutritionCard(pottasium)
          ],
        ));
      },
    );
  }

  Widget _nutritionCard(NutritionPredictionModel model) {
    return Expanded(
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${model.name} (${model.chemicalName})",
              style: const TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.value.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  model.unit,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
