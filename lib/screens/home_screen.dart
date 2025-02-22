import 'dart:ui';

import 'package:cooply/screens/login_logout_screen.dart';
import 'package:cooply/widgets/SimpleTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// @movers
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double offsetScreen = screenHeight * 0.12;

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(200),
          child:   AppBar(
            // title: Text("Mawae"),
            flexibleSpace: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Color(0xFFEAF5E4),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), // Adjust opacity (0.0 to 1.0)
                      BlendMode.dstATop, // Blend the opacity with the image
                    ),
                    child: Image.asset('assets/home_image.png', fit: BoxFit.cover),
                  ),
                ),
                Container(

                  child: Center(child: Image.asset(
                    'assets/cooply_sm.png',
                    // Adjust how the image fits inside the box
                  ),),
                ),




              ],
            )

                /*
            Container(
              height: 400,
              child: Center( child: Text("SEEEE")),
              color: Colors.yellow.shade100,

            ),*/
          )
      )

      ,
        body:
     DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                  ),
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: "LOGIN"),
                      Tab(text: "SIGN UP"),
                    ],
                  ),
                ),
                Expanded(child: TabBarView(children: [Text("teee"), Text("veeee")]))
              ],
            ),
          )



    );
  }
}
