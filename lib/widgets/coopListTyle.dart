import 'dart:math';

import 'package:Cooply/models/dtos/coop.dart';
import 'package:Cooply/models/dtos/farm.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/SvgIcon.dart';
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
            // borderRadius: BorderRadius.circular(12),
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
                alignment: Alignment.topCenter,
                //image Container
                padding:EdgeInsets.only(top: 10) ,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: null,

                ),
                // color: Colors.yellow,
                width: Util.scaleWidthFromDesign(context,20),
                height:Util.scaleWidthFromDesign(context, 125),
                child:   Icon( FontAwesomeIcons.buildingColumns,size: Util.scaleWidthFromDesign(context,12),)
                  ,

                //Image.asset("assets/icon/total_stock.png")
                //
                //Icon( FontAwesomeIcons.penToSquare,size: Util.scaleWidthFromDesign(context,12),)
                //SvgPicture.asset('assets/svg/place.svg',)
                //Text("🏡",style:TextStyle(fontSize: Util.scaleWidthFromDesign(context, 20)))


              ),
              Container(
                width: Util.scaleWidthFromDesign(context,2),
                height: Util.scaleWidthFromDesign(context,130), // You can adjust height as needed
                color: Colors.white, // Add your desired color
              ),
              Container(
                height: Util.scaleWidthFromDesign(context,125),
                width: Util.scaleWidthFromDesign(context,260),
                // color: Colors.red,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child:
                      Text(
                        "${coop.name} #${coop.reference} ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Util.scaleWidthFromDesign(context,15),
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),

                    Row(
                       children: [
                         Row(
                           children: [
                             Container( //t
                               // color: Colors.blue,
                               alignment: Alignment.centerLeft,
                               child: Image.asset("assets/icon/total_stock.png",width: 13,)
                             ),
                             Container(
                               // color: Colors.red,
                               alignment: Alignment.centerLeft,
                               child: Text(
                                 " ${Util.formatCount(coop.capacity)}",
                                 style: TextStyle(
                                     fontWeight: FontWeight.w300,
                                     fontSize: Util.scaleWidthFromDesign(context,9),
                                     fontFamily: AppConstants.defaultFont,
                                   shadows: [
                                     Shadow(
                                       offset: Offset(2, 2),
                                       blurRadius: 4.0,
                                       color: Colors.grey.withOpacity(0.5), // Shadow color
                                     ),
                                   ],

                                 ),
                               ),
                             )
                           ],
                         )
                         ,

//todo : Percentage Flock vs Coop Capacity.  how much of the qckquired flock is in the flock
// todo: should we look at the acquired flock or current flock. coz some flock might die.

                         Row(
                           children: [
                             Container( //t
                                 padding: EdgeInsets.only(left: 3),// his is
                                 // his is
                               // color: Colors.blue,
                                 alignment: Alignment.centerLeft,
                                 child: Image.asset("assets/icon/capacity_per.png",width: 15,)
                             ),
                             Container(
                               // color: Colors.red,
                               alignment: Alignment.centerLeft,
                               child: Text(
                                 "${Util.findPercentage(coop.acquiredFlock,coop.capacity)}%",
                                 style: TextStyle(
                                   fontWeight: FontWeight.w300,
                                   fontSize: Util.scaleWidthFromDesign(context,9),
                                   fontFamily: AppConstants.defaultFont,
                                   shadows: [
                                     Shadow(
                                       offset: Offset(2, 2),
                                       blurRadius: 4.0,
                                       color: Colors.grey.withOpacity(0.5), // Shadow color
                                     ),
                                   ],

                                 ),
                               ),
                             )
                           ],
                         )
                         ,
//todo: type or system being used. deep liter, mixed, or
                         Row(
                           children: [
                             Container( //t
                                 padding: EdgeInsets.only(left: 3),// his is
                                 // his is
                                 // color: Colors.blue,
                                 alignment: Alignment.centerLeft,
                                 child: Image.asset("assets/icon/blocks.png",width: 15,)
                             ),
                             Container(
                               // color: Colors.red,
                               alignment: Alignment.centerLeft,
                               child: Text(
                                 "${coop.type}",
                                 style: TextStyle(
                                   fontWeight: FontWeight.w300,
                                   fontSize: Util.scaleWidthFromDesign(context,9),
                                   fontFamily: AppConstants.defaultFont,
                                   shadows: [
                                     Shadow(
                                       offset: Offset(2, 2),
                                       blurRadius: 4.0,
                                       color: Colors.grey.withOpacity(0.5), // Shadow color
                                     ),
                                   ],

                                 ),
                               ),
                             )
                           ],
                         )
                         ,


                       ],
                    ),


                    Row(
                      children: [
                        Row(
                          children: [
                            Container( //t
                              // color: Colors.blue,
                                alignment: Alignment.centerLeft,
                                child: Image.asset("assets/icon/layer_block.png",width: 13,)
                            ),
                            Container(
                              // color: Colors.red,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " ${Util.formatCount(coop.currentFlock)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: Util.scaleWidthFromDesign(context,9),
                                  fontFamily: AppConstants.defaultFont,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 4.0,
                                      color: Colors.grey.withOpacity(0.5), // Shadow color
                                    ),
                                  ],

                                ),
                              ),
                            )
                          ],
                        )
                        ,

//todo : Percentage Current Flock vs Arquired Flock
                        Row(
                          children: [
                            Container( //t
                                padding: EdgeInsets.only(left: 3),// his is
                                // his is
                                // color: Colors.blue,
                                alignment: Alignment.centerLeft,
                                child: Image.asset("assets/icon/capacity_per.png",width: 15,)
                            ),
                            Container(
                              // color: Colors.red,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${Util.findPercentage(coop.currentFlock,coop.acquiredFlock)}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: Util.scaleWidthFromDesign(context,9),
                                  fontFamily: AppConstants.defaultFont,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 4.0,
                                      color: Colors.grey.withOpacity(0.5), // Shadow color
                                    ),
                                  ],

                                ),
                              ),
                            )
                          ],
                        )
                        ,

                        //todo: Stage
                        Row(
                          children: [
                            Container( //t
                                padding: EdgeInsets.only(left: 3),// his is
                                // his is
                                // color: Colors.blue,
                                alignment: Alignment.centerLeft,
                                child: Image.asset("assets/chicken.png",width: 17,)
                            ),
                            Container(
                              // color: Colors.red,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " Grower(10%),Starter(80%) ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: Util.scaleWidthFromDesign(context,9),
                                  fontFamily: AppConstants.defaultFont,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 4.0,
                                      color: Colors.grey.withOpacity(0.5), // Shadow color
                                    ),
                                  ],

                                ),
                              ),
                            )
                          ],
                        )
                        ,


                      ],
                    ),



                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Type : ${coop.type}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: Util.scaleWidthFromDesign(context,12),
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Capacity : ${coop.capacity}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: Util.scaleWidthFromDesign(context,12),
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Flock : ${coop.currentFlock}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: Util.scaleWidthFromDesign(context,12),
                            fontFamily: AppConstants.defaultFont),
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
