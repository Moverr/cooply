import 'dart:math';

import 'package:Cooply/cards/map_card.dart';
import 'package:Cooply/models/dtos/coop.dart';
import 'package:Cooply/models/dtos/farm.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/SvgIcon.dart';
import '../utils/util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class CoopListTyle extends StatefulWidget {
  final Coop coop;
  final VoidCallback? onTap;
  CoopListTyle({Key? key, required this.coop, this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CoopListTyleState();
}

class _CoopListTyleState extends State<CoopListTyle> {
  bool _showMap = false;

  late Coop coop;
  late VoidCallback? onTap;

  // Coordinates for Musima, Jinja, Uganda (approx)
  final LatLng _location = LatLng(0.4564, 33.1892);

  @override
  Widget build(BuildContext context) {
    coop = widget.coop;
    onTap = widget.onTap;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: Util.scaleWidthFromDesign(context, 200),
        margin: EdgeInsets.symmetric(
            vertical: Util.scaleWidthFromDesign(context, 8), horizontal: 16),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(Util.scaleWidthFromDesign(context, 12)),
          boxShadow: [
            BoxShadow(
              color: Color(0XFFCDB4B4),
              // blurRadius:  Util.scaleWidthFromDesign(context,1),
              offset: Offset(Util.scaleWidthFromDesign(context, 0),
                  Util.scaleWidthFromDesign(context, 0.5)),
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        child: Expanded(
            child: Column(
          children: [
            Row( // top level
              children: [
                Row(  //first section
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      //image Container
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: null,
                      ),
                      // color: Colors.yellow,
                      width: Util.scaleWidthFromDesign(context, 20),
                      height: Util.scaleWidthFromDesign(context, 125),
                      child: Icon(
                        FontAwesomeIcons.buildingColumns,
                        size: Util.scaleWidthFromDesign(context, 12),
                      ),

                      //Image.asset("assets/icon/total_stock.png")
                      //
                      //Icon( FontAwesomeIcons.penToSquare,size: Util.scaleWidthFromDesign(context,12),)
                      //SvgPicture.asset('assets/svg/place.svg',)
                      //Text("🏡",style:TextStyle(fontSize: Util.scaleWidthFromDesign(context, 20)))
                    ),
                    Container(
                      width: Util.scaleWidthFromDesign(context, 2),
                      height: Util.scaleWidthFromDesign(
                          context, 130), // You can adjust height as needed
                      color: Colors.white, // Add your desired color
                    ),
                    Container(
                      height: Util.scaleWidthFromDesign(context, 125),
                      width: Util.scaleWidthFromDesign(context, 260),
                      // color: Colors.red,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        spacing: 12, // horizontal space between items
                        runSpacing: 8, // vertical space between lines when wrapped

                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${coop.name} #${coop.reference} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Util.scaleWidthFromDesign(context, 15),
                                  fontFamily: AppConstants.defaultFont),
                            ),
                          ),

                          Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    //t
                                    // color: Colors.blue,
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        "assets/icon/total_stock.png",
                                        width: 13,
                                      )),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " ${Util.formatCount(coop.capacity)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                        Util.scaleWidthFromDesign(context, 11),
                                        fontFamily: AppConstants.defaultFont,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 4.0,
                                            color: Colors.grey
                                                .withOpacity(0.5), // Shadow color
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

//todo : Percentage Flock vs Coop Capacity.  how much of the qckquired flock is in the flock
// todo: should we look at the acquired flock or current flock. coz some flock might die.

                              Row(
                                children: [
                                  Container(
                                    //t
                                      padding: EdgeInsets.only(left: 3), // his is
                                      // his is
                                      // color: Colors.blue,
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        "assets/icon/capacity_per.png",
                                        width: 15,
                                      )),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${Util.findPercentage(coop.acquiredFlock, coop.capacity)}%",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                        Util.scaleWidthFromDesign(context, 11),
                                        fontFamily: AppConstants.defaultFont,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 4.0,
                                            color: Colors.grey
                                                .withOpacity(0.5), // Shadow color
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
//todo: type or system being used. deep liter, mixed, or
                              Row(
                                children: [
                                  Container(
                                    //t
                                      padding: EdgeInsets.only(left: 3), // his is
                                      // his is
                                      // color: Colors.blue,
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        "assets/icon/blocks.png",
                                        width: 15,
                                      )),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${coop.type}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                        Util.scaleWidthFromDesign(context, 11),
                                        fontFamily: AppConstants.defaultFont,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 4.0,
                                            color: Colors.grey
                                                .withOpacity(0.5), // Shadow color
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    //t
                                    // color: Colors.blue,
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        "assets/icon/layer_block.png",
                                        width: 13,
                                      )),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " ${Util.formatCount(coop.currentFlock)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                        Util.scaleWidthFromDesign(context, 11),
                                        fontFamily: AppConstants.defaultFont,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 4.0,
                                            color: Colors.grey
                                                .withOpacity(0.5), // Shadow color
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

//todo : Percentage Current Flock vs Arquired Flock
                              Row(
                                children: [
                                  Container(
                                    //t
                                      padding: EdgeInsets.only(left: 3), // his is
                                      // his is
                                      // color: Colors.blue,
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        "assets/icon/capacity_per.png",
                                        width: 15,
                                      )),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${Util.findPercentage(coop.currentFlock, coop.acquiredFlock)}%",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                        Util.scaleWidthFromDesign(context, 11),
                                        fontFamily: AppConstants.defaultFont,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 4.0,
                                            color: Colors.grey
                                                .withOpacity(0.5), // Shadow color
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              //todo: Stage
                              Row(
                                children: [
                                  Container(
                                    //t
                                      padding: EdgeInsets.only(left: 3), // his is
                                      // his is
                                      // color: Colors.blue,
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        "assets/chicken.png",
                                        width: 17,
                                      )),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Flexible(
                                      child: Text(
                                        " Grower ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: Util.scaleWidthFromDesign(
                                              context, 11),
                                          fontFamily: AppConstants.defaultFont,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2, 2),
                                              blurRadius: 4.0,
                                              color: Colors.grey
                                                  .withOpacity(0.5), // Shadow color
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              //todo: Vaccination
                              Row(
                                children: [
                                  Container(
                                    //t
                                      padding: EdgeInsets.only(left: 3), // his is
                                      // his is
                                      // color: Colors.blue,
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        "assets/icon/syringe.png",
                                        width: 17,
                                      )),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      " 12% ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                        Util.scaleWidthFromDesign(context, 11),
                                        fontFamily: AppConstants.defaultFont,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 4.0,
                                            color: Colors.grey
                                                .withOpacity(0.5), // Shadow color
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),

//todo:  last layer, showing  type of birds,  and pin of the coop
                          Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    //t
                                    // color: Colors.blue,
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        "assets/icon/blocks.png",
                                        width: 13,
                                      )),
                                  SizedBox(
                                      child: Container(
                                        // color: Colors.red,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "  layers",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                            Util.scaleWidthFromDesign(context, 11),
                                            fontFamily: AppConstants.defaultFont,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(2, 2),
                                                blurRadius: 4.0,
                                                color: Colors.grey
                                                    .withOpacity(0.5), // Shadow color
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),

//icon: Icon( FontAwesomeIcons.penToSquare,size:  Util.scaleWidthFromDesign(context,15),)

                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    FontAwesomeIcons.houseFlag,
                                    size: Util.scaleWidthFromDesign(context, 10),
                                  )),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "  ${coop.farmName}",
                                  style: TextStyle(
                                    // color: Colors.green.shade200,
                                      fontWeight: FontWeight.w200,
                                      fontSize:
                                      Util.scaleWidthFromDesign(context, 10),
                                      fontFamily: AppConstants.defaultFont),
                                ),
                              ),

                              //todo: location

                              Container(
                                //t
                                  padding: EdgeInsets.only(left: 3), // his is
                                  // his is
                                  // color: Colors.blue,
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    "assets/icon/map-pin.png",
                                    width: 17,
                                  )),
                              Container(
                                // color: Colors.red,
                                alignment: Alignment.centerLeft,
                                child: // Your widget:
                                MouseRegion(
                                  cursor: SystemMouseCursors
                                      .click, // Show pointer cursor on hover
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showMap =
                                        !_showMap; // Toggle the map visibility
                                      });
                                    },
                                    child: Text(
                                      "musima, jinja, Uganda",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                        Util.scaleWidthFromDesign(context, 11),
                                        fontFamily: AppConstants.defaultFont,
                                        color: Color(0xFF1C71C1),
                                        decoration: TextDecoration
                                            .underline, // underline to look like a link
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 4.0,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                Column( //Right Section
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: Util.scaleWidthFromDesign(context, 100)  ,

                      child:  IconButton(onPressed: (){

                      }, icon: Icon( FontAwesomeIcons.penToSquare,size:  Util.scaleWidthFromDesign(context,15),)
                      ),

                    ),

                    Container(
                      alignment: Alignment.bottomCenter,


                      child: Text(  "  ${coop.status}"),

                    ),



                  ],
                )
              ],
            ),


            //Map Display
            MapCard(
              location: _location,
            ),
            //bottom, which is the map level
          ],
        )),
      ),
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
