import 'dart:math';

import 'package:Cooply/models/dtos/LoginResponse.dart';
import 'package:Cooply/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../core/di/service_locator.dart';
import '../../models/MenuDto.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../providers/auth_provider.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isExpanded = true;


  final List<Menu> _menuList = [
    const Menu(item: "Overview", asset: "assets/overview.png",faIcon:FontAwesomeIcons.chartBar ),
    const Menu(item: "Farm", asset: "assets/farm.png",faIcon:FontAwesomeIcons.solidBuilding ),
    const Menu(item: "Reports", asset: "assets/reports.png",faIcon:FontAwesomeIcons.fileLines ),
    const Menu(item: "Users", asset: "assets/users.png",faIcon:FontAwesomeIcons.users ),
  ];

  // final authProvider = GetIt.I<AuthProvider>();

  AuthService authService = getIt<AuthService>();
  //todo: implement the user profile KYC information
  //todo: add the username on the response
  LoginResponse? loginData ;

 late  String username ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     authService.getStoredLoginData()
    .then((result)=>{
         if (result != null) {
            username = result.username
       }
     });
  }


  @override
  Widget build(BuildContext context) {


    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      //  appBar: AppBar(
      //   title: const Text("Dashboard"),
      //   leading: IconButton(
      //     icon: const Icon(Icons.menu),
      //     onPressed: () {
      //       setState(() {
      //         isExpanded = !isExpanded;
      //       });
      //     },
      //   ),
      // ),

      body: Center(
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
                                    authProvider.logResponse?.username??" na ",
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


                  ... _menuList.map((menu) => Column(
                    children: [
                      _MenuItem(menu.asset, menu.item,menu.faIcon),
                      _Divider(),
                    ],
                  )),

                  const Spacer(),
                  _MenuItem("assets/profile_icon.png", "Profile",FontAwesomeIcons.user),
                  _Divider(),
                  _MenuItem("assets/logout.png", "Logout",FontAwesomeIcons.arrowRightFromBracket),
                //isLogout: true),


                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Center(
                child: Text(
                  isExpanded ? "Sidebar Expanded" : "Sidebar Minimized",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  InkWell _MenuItem(String asset, String title,IconData faIcon) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
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
/*
            Image.asset(
              asset,
              height: 40,
              width: 40,
            ),
            */
          Container(
            width: 30,
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: FaIcon(
              faIcon, // Replace with the icon you need
              size: 15,


              color: Color(0xFF000000),    // Optional: specify icon color
            ),

          )
            ,
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
    return (isExpanded ==false) ?
     Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Divider(color: Colors.black12, thickness: 1),
    ) :  Container(

    );

  }


}
