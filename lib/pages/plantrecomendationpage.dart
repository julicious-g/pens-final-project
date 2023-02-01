import 'package:final_project/services/recommendation/plant_recommendation_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/plant.dart';
import '../route/hero_dialog_route.dart';

class PlantRecomendationPage extends StatefulWidget {
  const PlantRecomendationPage({Key? key}) : super(key: key);

  @override
  State<PlantRecomendationPage> createState() =>
      _PlantRecommendationPageState();
}

class _PlantRecommendationPageState extends State<PlantRecomendationPage> {
  late PlantRecommendationService _service;
  _PlantRecommendationPageState() {
    _service = GetIt.instance<PlantRecommendationService>();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _service.listenable(),
        builder: (context, child) {
          var plantIds = _service.plantIdsOrderedByProperties();

          return ListView.builder(
              itemCount: plantIds.length,
              itemBuilder: (context, index) {
                var plant = _service.plant(plantIds[index]);

                return _plantCard(plant);
              });
        });
  }

  Widget _plantCard(Plant plant) {
    return Hero(
      tag: "detail-popup-hero-${plant.id}",
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: () {
            // print("Card on tap");
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return _AddTodoPopupCard(
                plant: plant,
              );
            }));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(plant.latinName)
                      ],
                    ),
                    // _matchIcon(plant)
                  ],
                ),
                Column(
                  children: const [Divider()],
                ),
                // Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.science, color: Colors.blue),
                        Text(_service.phFeasibilityLevel(plant))
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.water_drop, color: Colors.blue),
                        Text(_service.moistureFeasibilityLevel(plant))
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.thermostat, color: Colors.blue),
                        Text(_service.temperatureFeasibilityLevel(plant))
                      ],
                    ),
                    // _plantAcidityDetail(plant),
                    // _plantSalinityDetail(plant)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isDone(ConnectionState state) => state == ConnectionState.done;
}

class _AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  final Plant _plant;
  const _AddTodoPopupCard({Key? key, required Plant plant})
      : _plant = plant,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "detail-popup-hero-${_plant.id}",
          // createRectTween: (begin, end) {
          //   return CustomRectTween(begin: begin, end: end);
          // },
          child: Material(
            // color: AppColors.accentColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [Text("Detail")]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
