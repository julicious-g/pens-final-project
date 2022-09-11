import 'package:final_project/pages/dashboard.dart';
import 'package:final_project/pages/fertilizerrecomendationpage.dart';
import 'package:final_project/pages/plantrecomendationpage.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends StatefulWidget {
  @override
  State createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
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
          const PlantRecomendationPage(),
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
