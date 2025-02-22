import 'package:cooply/widgets/SimpleTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// @movers
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    double offsetScreen = screenHeight * 0.12;

    return Scaffold(
    body: ListView(

      shrinkWrap: true,  // Prevents unnecessary extra space
      physics: NeverScrollableScrollPhysics(), // Disables independent scrolling
      padding: EdgeInsets.zero, // Removes default padding

      children: [

Stack(
  alignment: Alignment.center,
  children: [

    Container(
width: double.infinity,
      height: 200,
        // color: Color(0xFFEAF5E4),
      child: Image.asset('assets/home_image.png',
        fit: BoxFit.cover
      ),
    ),

    Container(

      width: double.infinity,
      height: 200,
      child:  SimpleTextWidget(
        title: " \n \n  \n \n \n \n khoodilabs © 2025 ",
        fontFamily: "Inria Serif",
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
      // color: Colors.red,
    ),


  ],
),

        Container(
          // padding: EdgeInsets.only(left: 10, top: 65, right: 20, bottom: 15),
          height: screenHeight * 0.30, color: Color(0xFFEAF5E4),
          child: Image.asset('assets/home_screen_image.png',
           fit: BoxFit.fill,
          ),
          //assets/home_screen_image.png
        ),

       Transform.translate(
         offset:   Offset(0, 0),
         child: Container(
           height: screenHeight * 0.75, color: Colors.deepOrange.shade100,
           child: Text("LOW  Layer"),
         ),
       ),


      ],
    )
  );
  }
  
}