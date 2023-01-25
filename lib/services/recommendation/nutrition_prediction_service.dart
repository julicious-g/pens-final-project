import 'package:final_project/models/nutrition_prediction_model.dart';

class NutritionPredictionService {
  static NutritionPredictionModel phosporus(double ph) {
    var value = -51.86 * ph + 433.47;
    return NutritionPredictionModel(
        name: "Phosporus",
        unit: "mg/kg",
        value: value,
        chemicalName: "P2O5",
        model: "y = -51.86 * ph + 433.47");
  }

  static NutritionPredictionModel phosporus2(double ph, double cec) {
    var value = 55.57924 + (-4.00611) * ph + (0.63728) * cec;
    return NutritionPredictionModel(
        name: "Phosporus",
        unit: "mg/kg",
        value: value,
        chemicalName: "P2O5",
        model: "y = 55.57924 + (-4.00611) pH + (0.63728)CEC");
  }

  static NutritionPredictionModel pottasium(double ph, double cec) {
    var value = (-10.87555) + (8.48561) * ph + (9.47799) * cec;
    return NutritionPredictionModel(
        name: "Pottasium",
        unit: "mg/kg",
        value: value,
        chemicalName: "K2O",
        model: "y = (-10.87555) + (8.48561) * pH +(9.47799) * CEC");
  }

  static NutritionPredictionModel nitrogen(
      double soilMoisture, double temperature) {
    var value = 39.12782 + (-3.23536 * soilMoisture) + 1.40814 * temperature;
    return NutritionPredictionModel(
        name: "Nitrogen",
        unit: "micrograms/gram",
        value: value,
        chemicalName: "NO3",
        model: "y = 39.12782 + ( - 3.23536 M ) + 1.40814 T");
  }

  static NutritionPredictionModel cec(double ph) {
    var value = 1.6648 * ph - 1.0236;
    return NutritionPredictionModel(
        name: "CEC",
        unit: "",
        value: value,
        chemicalName: "",
        model: "y = 1.6648ph - 1.0236");
  }
}
