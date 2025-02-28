import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/AppConstants.dart';
import '../widgets/SimpleTextWidget.dart';
import '../widgets/SplashImageWidget.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      //todo: open the home screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: ListView(
      children: [
        Container(
          child: SplashImageWidget(),
          height: screenHeight * 0.86,
        ),
        Container(
            height: screenHeight * 0.10,
            color: Color(0xFFE1EAD1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SimpleTextWidget(
                  title: AppConstants.appVersion,
                  fontFamily:  AppConstants.fontFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                ),
                SimpleTextWidget(
                  title: AppConstants.companyName + " © "+AppConstants.currentYear,
                  fontFamily: AppConstants.fontFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                )
              ],
            )
            //Text("Footer",textAlign: TextAlign.center,),

            )
      ],
    ));
  }
}
