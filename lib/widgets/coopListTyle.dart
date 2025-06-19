import 'dart:math';

import 'package:Cooply/models/dtos/coop.dart';
import 'package:Cooply/models/dtos/farm.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/util.dart';

class CoopListTyle extends StatelessWidget {
  final Coop coop;
  final VoidCallback? onTap;

  CoopListTyle({Key? key, required this.coop, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: Util.scaleWidthFromDesign(context,125),
          margin:   EdgeInsets.symmetric(vertical:Util.scaleWidthFromDesign(context,8) , horizontal: 16),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow:   [
              BoxShadow(
                color: Color(0XFFCDB4B4),
                blurRadius:  Util.scaleWidthFromDesign(context,1),
                offset: Offset( Util.scaleWidthFromDesign(context,0),  Util.scaleWidthFromDesign(context,3)),
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
                width: Util.scaleWidthFromDesign(context,120),
                height:Util.scaleWidthFromDesign(context, 125),
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
                width: Util.scaleWidthFromDesign(context,2),
                height: Util.scaleWidthFromDesign(context,130), // You can adjust height as needed
                color: Colors.white, // Add your desired color
              ),
              Container(
                height: Util.scaleWidthFromDesign(context,125),
                width: Util.scaleWidthFromDesign(context,150),
                padding: const EdgeInsets.all(5),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        coop.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: Util.scaleWidthFromDesign(context,13),
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        coop.farmName!,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: Util.scaleWidthFromDesign(context,12),
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Type : ${coop.type}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: Util.scaleWidthFromDesign(context,12),
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Capacity : ${coop.capacity}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: Util.scaleWidthFromDesign(context,12),
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Flock : ${coop.currentBirdCount}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: Util.scaleWidthFromDesign(context,12),
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
                      height: Util.scaleWidthFromDesign(context,80),
                      // color: Colors.blue,
                      alignment: Alignment.topRight,
                      child: IconButton(onPressed: (){

                      }, icon: Icon( FontAwesomeIcons.penToSquare,size: Util.scaleWidthFromDesign(context,12),)
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child:Text(
                        "${coop.status!.toUpperCase()}",
                        style:   TextStyle(fontSize: Util.scaleWidthFromDesign(context,9),fontWeight: FontWeight.normal),
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
