import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: const <Widget>[
        Expanded(
            child: Card(
          child: Center(
            child: ListTile(
              leading: Icon(Icons.science),
              title: Text("5.7",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              subtitle: Text("pH"),
            ),
          ),
          elevation: 10,
        )),
        Expanded(
            child: Card(
          child: Center(
            child: ListTile(
              leading: Icon(Icons.bolt),
              title: Text(
                "2.1 dS/cm",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Salinity"),
            ),
          ),
          elevation: 10,
        )),
        Expanded(
            child: Card(
          child: Center(
            child: ListTile(
              leading: Icon(Icons.water_drop),
              title: Text(
                "38 %",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Moisture"),
            ),
          ),
          elevation: 10,
        ))
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    ));
  }
}
