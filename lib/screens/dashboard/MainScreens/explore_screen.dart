

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ExploreState();

}

class _ExploreState extends State<ExploreScreen>{

  final List<String> tabTitles = ['Overview', 'Farm', 'Coop','Flock','Feeds','Health']; // Dynamic list


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:  DefaultTabController(
          length: tabTitles.length,
          child: Align(
              alignment: Alignment.topLeft, // Aligns TabBar to the left
child:
              TabBar(
                isScrollable: true,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                padding: EdgeInsets.zero,          // Remove internal padding
                labelPadding: EdgeInsets.only(right: 16,left: 16), // Adjust space between tabs
                tabs: tabTitles.map((title) => Tab(text: title)).toList(),
              ),


          )
      )
    );


  }

}