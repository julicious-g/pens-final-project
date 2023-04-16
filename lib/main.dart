import 'dart:ui';

import 'package:final_project/main_screen_page.dart';
import 'package:final_project/services/recommendation/plant_recommendation_service.dart';
import 'package:final_project/services/sensor/dummy_sensor_service.dart';
import 'package:final_project/services/sensor/sensor_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DartPluginRegistrant.ensureInitialized();
  await setupServices();
  runApp(const FinalProjectApp());
}

Future<void> setupServices() async {
  GetIt.I.registerSingleton<SensorService>(await DummySensorService().init());
  // GetIt.I.registerSingleton<SensorService>(await HttpSensorService().init());
  GetIt.I.registerSingleton<PlantRecommendationService>(
      await PlantRecommendationService().init());
}

class FinalProjectApp extends StatelessWidget {
  const FinalProjectApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
      ),
      home: MainScreenPage(),
      initialRoute: "/",
    );
  }
}
