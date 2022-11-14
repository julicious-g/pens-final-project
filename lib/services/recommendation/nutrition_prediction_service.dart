class NutritionPredictionService {
  static NutritionPredictionModel phosporus(double ph) {
    var value = -51.86 * ph + 433.47;
    return NutritionPredictionModel(
        name: "Phosporus",
        unit: "ppm",
        value: value,
        chemicalName: "P2O5",
        model: "y = -51.86 * ph + 433.47");
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

class NutritionPredictionModel {
  late String name;
  late String unit;
  late double value;
  late String chemicalName;
  late String model;

  NutritionPredictionModel(
      {this.name = "",
      this.unit = "",
      this.value = 0.0,
      this.chemicalName = "",
      this.model = ""});
}
