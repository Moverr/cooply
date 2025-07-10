import 'dart:math';

import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/dtos/flock.dart';
import '../utils/util.dart';

class FlockListTyle extends StatelessWidget {
  final Flock flock;
  final VoidCallback? onTap;

  FlockListTyle({Key? key, required this.flock, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
          height:  Util.scaleWidthFromDesign(context,125),
          margin:   EdgeInsets.symmetric(vertical:  Util.scaleWidthFromDesign(context,8), horizontal:  Util.scaleWidthFromDesign(context,16)),
          padding:   EdgeInsets.all( Util.scaleWidthFromDesign(context,5)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular( Util.scaleWidthFromDesign(context,12)),

            boxShadow:   [
              BoxShadow(
                color: Color(0XFFCDB4B4),
                // blurRadius:  Util.scaleWidthFromDesign(context,1),
                offset: Offset( Util.scaleWidthFromDesign(context,0),  Util.scaleWidthFromDesign(context,0.5)),
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
                  borderRadius: BorderRadius.circular( Util.scaleWidthFromDesign(context,12)),
                  boxShadow: null,
                ),
                // color: Colors.yellow,
                width: Util.scaleWidthFromDesign(context, 120),
                height: Util.scaleWidthFromDesign(context, 120),
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
                width:  Util.scaleWidthFromDesign(context,2),
                height:  Util.scaleWidthFromDesign(context,120), // You can adjust height as needed
                color: Colors.white, // Add your desired color
              ),
              Container(
                height:  Util.scaleWidthFromDesign(context,120),
                width:  Util.scaleWidthFromDesign(context,150),
                padding:   EdgeInsets.all( Util.scaleWidthFromDesign(context,2)),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "BN : ${flock.batchName}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize:  Util.scaleWidthFromDesign(context,11),
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Acquired : ${flock.acquiredOn!}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize:  Util.scaleWidthFromDesign(context,11),
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Type : ${flock.type}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize:  Util.scaleWidthFromDesign(context,11),
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Current Stock : ${flock.currentBirdCount}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize:  Util.scaleWidthFromDesign(context,11),
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Stock : ${flock.stock}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize:  Util.scaleWidthFromDesign(context,11),
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mortality : ${flock.mortality}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize:  Util.scaleWidthFromDesign(context,11),
                            fontFamily: AppConstants.defaultFont),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Container(
                      height:  Util.scaleWidthFromDesign(context,70),
                      // color: Colors.blue,
                      alignment: Alignment.topRight,
                      child: IconButton(onPressed: (){

                      }, icon: Icon( FontAwesomeIcons.penToSquare,size:  Util.scaleWidthFromDesign(context,15),)
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child:Text(
                        "${flock.status!.toUpperCase()}",
                        style:   TextStyle(fontSize:  Util.scaleWidthFromDesign(context,11),fontWeight: FontWeight.normal),
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
