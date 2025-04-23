import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _OverviewState();


}

class _OverviewState extends State<OverviewScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
        "Overview Dashboard",
        style: const TextStyle(fontSize: 20),
    )
    )
    );

  }
  
}