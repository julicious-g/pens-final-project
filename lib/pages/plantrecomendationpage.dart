import 'package:flutter/material.dart';

import '../models/plant.dart';

class PlantRecomendationPage extends StatefulWidget {
  const PlantRecomendationPage({Key? key}) : super(key: key);

  @override
  State<PlantRecomendationPage> createState() =>
      _PlantRecommendationPageState();
}

class _PlantRecommendationPageState extends State<PlantRecomendationPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plant>>(
      future: Plant.fromFile(),
      builder: (context, snapshot) {
        if (!isDone(snapshot.connectionState)) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          // try to display error message
        }

        return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              var plant = snapshot.data![index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(plant.latinName),
                      Column(
                        children: const [Divider()],
                      ),
                      // Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _plantDetail(
                              plant.minPh, plant.maxPh, "", Icons.science),
                          _plantDetail(plant.minMoisture, plant.maxMoisture,
                              "%", Icons.water_drop),
                          _plantDetail(plant.minTemperature,
                              plant.maxTemperature, "C", Icons.thermostat),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget _plantDetail(
      String minValue, String maxValue, String unit, IconData icon) {
    return Column(
      children: [
        Icon(icon),
        Text("$minValue - $maxValue $unit"),
      ],
    );
  }

  bool isDone(ConnectionState state) => state == ConnectionState.done;
}
