import 'dart:async';


import 'package:Cooply/screens/verification_screen.dart';
import 'package:flutter/material.dart';

import '../utils/AppConstants.dart';
import '../widgets/footerWidget.dart';
import '../widgets/simpleTextWidget.dart';
import '../widgets/splashImageWidget.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      //todo: open the home screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  VerificationScreen()
          //HomeScreen()

      ));
    });

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: screenHeight * 0.86,
          child: SplashImageWidget(),
        ),
        Container(
            height: screenHeight * 0.10,
            color: Color(0xFFE1EAD1),
            child:  FooterWidget()
            //Text("Footer",textAlign: TextAlign.center,),

            )
      ],
    ));
  }


}
