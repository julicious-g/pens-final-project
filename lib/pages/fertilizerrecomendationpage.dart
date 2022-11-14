// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class FertilizerRecommendationPage extends StatefulWidget {
  const FertilizerRecommendationPage({Key? key}) : super(key: key);

  @override
  State<FertilizerRecommendationPage> createState() =>
      _FertilizerReccomendationPageState();
}

class _FertilizerReccomendationPageState
    extends State<FertilizerRecommendationPage> {
  double _value = 6;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Expanded(
          child: Card(
              child: Slider(
                  divisions: 60,
                  min: 4,
                  max: 10,
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  label: '$_value')),
        ),
        _nutritionCard("Nitrogen", "%", _nitrogen(_value)),
        _nutritionCard("Phosporus", "ppm", _phosporus(_value)),
        _nutritionCard("Pottasium", "ppm", _pottasium(_value)),
      ],
    ));
  }

  Widget _nutritionCard(String nutrition, String unit, double value) {
    return Expanded(
      child: Card(child: Text("${nutrition} : ${value}  ${unit}")),
    );
  }

  double _nitrogen(double ph) {
    var a = -0.056;
    var b = 0.54;
    var nitrogen = _regression(ph, a, b) * 100;

    return nitrogen.roundToDouble();
  }

  double _phosporus(double ph) {
    var a = -51.86;
    var b = 433.47;
    return _regression(ph, a, b);
  }

  double _pottasium(double ph) {
    var a = -3.8964;
    var b = 81.012;
    return _regression(ph, a, b);
  }

  double _regression(double x, double a, double b) {
    return (a * x + b);
  }
}
