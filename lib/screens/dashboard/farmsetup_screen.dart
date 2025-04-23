import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FarmSetupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FarmSetupSate();
}

class _FarmSetupSate extends State<FarmSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Farm Management",
          style: TextStyle(
              fontFamily: AppConstants.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Text(
            "Manage Farm",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Name',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Quantity',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Status',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Eggs'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('120'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Available'),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Chickens'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('45'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Healthy'),
                ),
              ]),
            ],
          ),
        ],
      )),
    );
  }
}
