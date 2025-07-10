import 'dart:math';

import 'package:Cooply/models/dtos/loginResponse.dart';
import 'package:Cooply/screens/dashboard/MainScreens/messages_screen.dart';
import 'package:Cooply/screens/dashboard/MainScreens/profie_screen.dart';
import 'package:Cooply/screens/dashboard/MainScreens/reports_screen.dart';
import 'package:Cooply/screens/dashboard/MainScreens/schedule_screen.dart';
import 'package:Cooply/screens/dashboard/farmsetup_screen.dart';
import 'package:Cooply/screens/dashboard/overview_screen.dart';
import 'package:Cooply/screens/home_screen.dart';
import 'package:Cooply/screens/splash_screen.dart';
import 'package:Cooply/services/AuthService.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../core/di/service_locator.dart';
import '../../models/menuDto.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../providers/auth_provider.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MainScreens/explore_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isExpanded = true;
  int _currentIndex = 0;

  final List<Menu> _menuList = [
    const Menu(
        name: "Overview",
        code: "overview",
        asset: "assets/overview.png",
        faIcon: FontAwesomeIcons.chartBar),

    const Menu(
        name: "Coops",
        code: "coops",
        asset: "assets/overview.png",
        faIcon: FontAwesomeIcons.twitter),


    const Menu(
        name: "Inventory",
        code: "inventory",
        asset: "assets/overview.png",
        faIcon: FontAwesomeIcons.listCheck),


    const Menu(
        name: "Sales & Expenses",
        code: "sales_expenses",
        asset: "assets/overview.png",
        faIcon: FontAwesomeIcons.chartBar),



    const Menu(
        name: "Schedules",
        code: "schedule",
        asset: "assets/overview.png",
        faIcon: FontAwesomeIcons.timeline),




    const Menu(
        name: "Reports",
        code: "reports",
        asset: "assets/reports.png",
        faIcon: FontAwesomeIcons.fileLines),


    const Menu(
        name: "Farm Setup",
        code : "farm_setup",
        asset: "assets/farm.png",
        faIcon: FontAwesomeIcons.gears),

    const Menu(
        name: "Users",
        code: "users",
        asset: "assets/users.png",
        faIcon: FontAwesomeIcons.users),
  ];

  final List<BottomNavigationBarItem> bottomMainMenu = [
    BottomNavigationBarItem(

      icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
      label: 'Explore',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.chartLine),
      label: 'Reports',
    ),

    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.calendar),
      label: 'Schedule',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.message),
      label: 'Messages',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.circleUser),
      label: 'Profile',
    ),
  ];

  // final authProvider = GetIt.I<AuthProvider>();

  AuthService authService = getIt<AuthService>();
  //todo: implement the user profile KYC information
  //todo: add the username on the response
  LoginResponse? loginData;

  late String username;

  String selectedMenu = "overview";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getStoredLoginData().then((result) => {
          if (result != null) {username = result.username}
        });
  }


  final List<Widget> _mainPages = [
    ExploreScreen(),
    ReportScreen(),
    ScheduleScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);


    return Scaffold(
       appBar: AppBar(
        title:  Row(
          children: [
            Image.asset(
              "assets/chicken.png",
              width: 40,
              height: 30,

            ),
            const Text(AppConstants.titleText,
                 style: TextStyle(
                   fontFamily: "inter",
                fontSize: 20,
                color: Color(0XFF3AAD8F),
                fontWeight: FontWeight.bold),
            ),
          ],
        ),


         actions: [
           IconButton(
             icon: Image.asset("assets/users.png",
               width: 40, height: 30,
             ),

             // const  FaIcon(FontAwesomeIcons.users),
             //Icon(Icons.notifications),
             onPressed: () {
               // Handle notification press
             },
           ),
           IconButton(
             icon:  const  FaIcon(FontAwesomeIcons.rss ),
             onPressed: () {
               // Handle settings press
             },
           ),

           IconButton(
             icon:  const  FaIcon(FontAwesomeIcons.gear),
             onPressed: () {
               // Handle settings press
             },
           ),

         ],

      ),


      body: _mainPages[_currentIndex],
          /*
      Center(
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isExpanded ? 150 : 50,
              decoration: const BoxDecoration(
                color: Color(0XFFE1EAD1),
                // boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 0)],
                /* borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),  // Top-right corner
                bottomRight: Radius.circular(20), // Bottom-right corner
              ),
              */
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Container(
                      width:
                          isExpanded ? 150 : 50, // Sidebar expands or collapses
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.max, // Prevents overflow
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Image.asset(
                            "assets/chicken.png",
                            height: 30,
                            width: 30,
                          ),
                          if (isExpanded) ...[
                            Expanded(
                              // <-- FIX: Forces text to fit within available space
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                    overflow: TextOverflow
                                        .ellipsis, // Prevents text overflow
                                    maxLines: 1,
                                  ),

                                  //todo: work on bringing the email
                                  Text(
                                    authProvider.logResponse?.username ??
                                        " na ",
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  _Divider(),

                  ..._menuList.map((menu) => Column(
                        children: [
                          _MenuItem(menu.asset, menu.name,menu.code, menu.faIcon),
                          _Divider(),
                        ],
                      )),

                  const Spacer(),
                  _MenuItem("assets/profile_icon.png", "Profile","profile",
                      FontAwesomeIcons.user),
                  _Divider(),
                  _MenuItem("assets/logout.png", "Logout","logout",
                      FontAwesomeIcons.arrowRightFromBracket),
                  const SizedBox(height: 30),
                  //isLogout: true),
                ],
              ),
            ),

            // Main Content
            Expanded(child: handleMenuItem(selectedMenu)),
          ],
        ),
      ),
*/
        bottomNavigationBar:
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor:  Color(0xFF3AAD8F),
          unselectedItemColor:  Color(0xFF000000),
          onTap: (index) => setState(() => _currentIndex = index),
          selectedLabelStyle: TextStyle(fontSize: 10,fontFamily: AppConstants.defaultFont, fontWeight: FontWeight.normal),
          unselectedLabelStyle: TextStyle(fontSize: 10, fontFamily: AppConstants.defaultFont, fontWeight: FontWeight.normal),
          items: bottomMainMenu,
 
        ),

    );
  }

  Container presetContainer() {
    return Container();
  }

  //Handle what Menu iTems see in the details page
  handleMenuItem(String menuItem) {
    isExpanded = false;
    switch (menuItem.toLowerCase().trim()) {
      case 'overview':
        return OverviewScreen();


      case 'farm_setup':
          return FarmSetupScreen();



      case 'reports':
        return Center(
          child: Text(
            "Reports",
            style: const TextStyle(fontSize: 20),
          ),
        );



      case 'users':
        return Center(
          child: Text(
            "Users",
            style: const TextStyle(fontSize: 20),
          ),
        );



      case 'profile':
        return Center(
          child: Text(
            "Profile",
            style: const TextStyle(fontSize: 20),
          ),
        );


      case 'logout':

        //todo: add logout information
      //todo: go to logout
      //todo: clear the auth provider and shared preferences
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SplashScreen()));


        break;








      default:
        return Center(
          child: Text(
            "Welcome Screen",
            style: const TextStyle(fontSize: 20),
          ),
        );
        break;
    }
  }

  InkWell _MenuItem(String asset, String title, String code,IconData faIcon) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedMenu = code;
        });
      },
      child: Container(
        width: isExpanded ? 150 : 50, // Sidebar expands or collapses
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min, // Prevents overflow
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              width: 30,
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: FaIcon(
                faIcon, // Replace with the icon you need
                size: 15,

                color: Color(0xFF000000), // Optional: specify icon color
              ),
            ),
            if (isExpanded) ...[
              Expanded(
                // <-- FIX: Forces text to fit within available space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                      overflow: TextOverflow.ellipsis, // Prevents text overflow
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Divider Widget
  Widget _Divider() {
    return (isExpanded == false)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(color: Colors.black12, thickness: 1),
          )
        : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Divider(color: Colors.white, thickness: 1),
    );
  }
}
