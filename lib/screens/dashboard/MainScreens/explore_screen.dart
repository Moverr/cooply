import 'package:Cooply/screens/dashboard/coops_screen.dart';
import 'package:Cooply/screens/dashboard/farmsetup_screen.dart';
import 'package:Cooply/screens/dashboard/flock_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feed_screen.dart';
import '../health_screen.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExploreState();
}

class _ExploreState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabTitles = [
    'Home',
    // 'Farm', // removed this from the main screen
    'Coop',
    'Flock',
    'Feeds',
    'Health'
  ]; // Dynamic list

  int _initialTabIndex = 0;
  bool _isTabControllerReady = false; // Flag to wait for async loading

  Future<void> _loadTabIndex() async {
    SharedPreferences prefs = await getPref();
    _initialTabIndex = prefs.getInt('exploreTabIndex') ?? 0;

    _tabController = TabController(
      length: tabTitles.length,
      vsync: this,
      initialIndex: _initialTabIndex,
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        prefs.setInt('exploreTabIndex', _tabController.index);
      }
    });

    setState(() {
      _isTabControllerReady = true; // Mark ready and rebuild
    }); // Trigger build after controller is ready
  }

  Future<SharedPreferences> getPref() async {
     final prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadTabIndex();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while waiting for controller
    if (!_isTabControllerReady) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
        body: SafeArea(

            // length: tabTitles.length,
            // child: Align(
            //     alignment: Alignment.topLeft, // Aligns TabBar to the left
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: false,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
          ),
          // padding: EdgeInsets.zero, // Remove internal padding
          // labelPadding: EdgeInsets.only(  right: 16, left: 16), // Adjust space between tabs
          tabs: tabTitles.map((title) => Tab(text: title)).toList(),
        ),
// Tab Views Divider(height: 1),
        Divider(height: 1),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Center(child: Text('Overview content')),
              // FarmSetupScreen(),
              CoopsScreen(),
              FlockScreen(),
              FeedScreen(),
              HealthScreen(),
            ],
          ),
        ),
      ],
    )));
    // ));
  }
}
