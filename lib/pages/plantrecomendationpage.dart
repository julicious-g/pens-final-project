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

              return ListTile(
                title: Text(plant.name),
                subtitle: Text(plant.latinName),
              );
            });
      },
    );
  }

  bool isDone(ConnectionState state) => state == ConnectionState.done;
}
