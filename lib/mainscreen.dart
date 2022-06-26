import 'package:final_project/dashboard.dart';
import 'package:final_project/fertilizerrecomendationpage.dart';
import 'package:final_project/plantrecomendationpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  @override
  State createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Final Project"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.device_thermostat), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.park), label: "Plant"),
          BottomNavigationBarItem(
              icon: Icon(Icons.science), label: "Fertilizer")
        ],
        currentIndex: _pageIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.lightGreen,
        unselectedItemColor: Colors.white.withOpacity(.5),
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _pageIndex,
        children: <Widget>[
          Dashboard(),
          PlantRecomendationPage(),
          FertilizerRecommendationPage()
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }
}
