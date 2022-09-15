import 'package:final_project/services/sensor/sensor_service.dart';
import 'package:get_it/get_it.dart';

import '../../models/plant.dart';

class PlantRecommendationService {
  final List<Plant> _plantData = List<Plant>.empty();
  late SensorService _sensorService;

  PlantRecommendationService() {
    _sensorService = GetIt.instance<SensorService>();
  }

  List<Plant> Plants() => _plantData;

  Future<PlantRecommendationService> init() async {
    var plants = await Plant.fromFile();
    _plantData.addAll(plants);
    return this;
  }
}
