import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MainScreens/schedule_screen.dart';
import 'healthscreens/overview_heatlh_screen.dart';

class HealthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HealthState();
}

class _HealthState extends State<HealthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> tabTitles = [
    Tab(text: "Overview", icon: FaIcon(FontAwesomeIcons.tableList)),
    Tab(text: "Schedule", icon: FaIcon(FontAwesomeIcons.calendarWeek))
  ]; // Dynamic

  int _initialTabIndex = 0;
  bool _isTabControllerReady = false; // Flag to wait for async loading

  Future<void> _loadTabIndex() async {
    final prefs = await SharedPreferences.getInstance();
    _initialTabIndex = prefs.getInt('healthScreenTabIndex') ?? 0;

    _tabController = TabController(
      length: tabTitles.length,
      vsync: this,
      initialIndex: _initialTabIndex,
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        prefs.setInt('healthScreenTabIndex', _tabController.index);
      }
    });

    setState(() {
      _isTabControllerReady = true; // Mark ready and rebuild
    }); // Trigger build after controller is ready
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
    if (!_isTabControllerReady) {
      return Scaffold(
          body: Center(
              child: CircularProgressIndicator(
        strokeWidth: 25,
        color: Colors.green,
      )));
    }

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: false,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          labelPadding: EdgeInsets.symmetric(horizontal: 8), // tighter spacing
          labelStyle: TextStyle(fontSize: 10), // smaller label
          unselectedLabelStyle: TextStyle(fontSize: 10),
          tabs: tabTitles
              .map(
                (record) => Tab(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 14, // smaller icon
                          height: 14,
                          child: record.icon,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Text(
                              record.text ?? " -  ",
                          style: const TextStyle(fontSize: 13),
                        ))
                      ]),
                ),
              )
              .toList(),
        ),


        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              OverviewHealthScreen(),
              ScheduleScreen(),
            ],
          ),
        ),
      ],
    ));
  }
}
