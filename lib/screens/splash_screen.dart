import 'dart:async';

import 'package:cooply/screens/home_screen.dart';
import 'package:cooply/widgets/SplashImageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  SplashImageWidget(),
      ),
      
    );
  }
}



/*
class SplashScreenState extends State<SplashScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.yellow,
        body: Center(
          child: Text("Mmovers"),

        ));
  }
}
*/
