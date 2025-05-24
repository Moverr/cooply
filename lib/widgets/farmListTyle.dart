import 'dart:math';

import 'package:Cooply/models/dtos/farm.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class farmListTyle extends StatelessWidget {
  final Farm farm;
  final VoidCallback? onTap;

  farmListTyle({Key? key, required this.farm, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 125,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0XFFCDB4B4),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                //image Container
                decoration: BoxDecoration(
                  // color: Color(0XFFF9F7EE),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: null,
                ),
                // color: Colors.yellow,
                width: 120,
                height: 125,
                child: Center(
                  child: getRandomImage()
                  /*  Text(
                  "WINK",
                  style: const TextStyle(fontSize: 18),
                ) */
                  ,
                ),
              ),
              Container(
                width: 2,
                height: 130, // You can adjust height as needed
                color: Colors.white, // Add your desired color
              ),
              Container(
                height: 125,
                width: 200,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        farm.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Location : Jinja,Uganda",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Coops : ${farm.coops}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ftock : ${farm.flock}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.fontFamily),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      // color: Colors.blue,
                      alignment: Alignment.topRight,
                      child: IconButton(onPressed: (){

                      }, icon: Icon( FontAwesomeIcons.penToSquare)
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child:Text(
                        "2024 Feb 18th",
                        style: const TextStyle(fontSize: 10,fontWeight: FontWeight.normal),
                      ) ,
                    )
                  ],
                ),

              )
              ,
            ],
          )),
    );
  }

  List<String> images = [
    "assets/chicken1.png",
    "assets/chicken2.png",
    "assets/chicken3.png",
    "assets/chicken4.png",
    "assets/chicken5.png",
    "assets/chicken6.png",
    "assets/chicken7.png",
  ];
  final random = Random();
  Image getRandomImage() {
    int number = random.nextInt(7);
    return Image.asset(images[number]);
  }
}
