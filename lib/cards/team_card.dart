


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/AppConstants.dart';
import '../utils/util.dart';

class TeamCard extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _TeamCardState();

}

class _TeamCardState extends State<TeamCard>{
  @override
  Widget build(BuildContext context)  => teamCard(context);

  Container teamCard(BuildContext context) {
    return Container(
        height: Util.scaleWidthFromDesign(context, 100),
        width: Util.scaleWidthFromDesign(context, 320),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.black38, width: 1.0, style: BorderStyle.solid)),
        ),
        child: Container(
          // color: Colors.green,
          width: double.infinity,
          alignment: Alignment.topLeft,

          child: Row(
            children: [
              Container(
                // color: Colors.yellow,
                  width: Util.scaleWidthFromDesign(context, 280),
                  // color: Colors.red,
                  child: Wrap(
                    children: [
                      Container(
                          width: Util.scaleWidthFromDesign(context, 50),
                          // color: Colors.green,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Team",
                                  style: TextStyle(
                                      fontFamily: AppConstants.defaultFont,
                                      fontSize: Util.scaleWidthFromDesign(
                                          context, 13),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Wrap(
                                    children: [
                                      Wrap(
                                        //farm card
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "2",
                                              style: TextStyle(
                                                  fontFamily:
                                                  AppConstants.defaultFont,
                                                  fontSize:
                                                  Util.scaleWidthFromDesign(
                                                      context, 12),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Members ",
                                              style: TextStyle(
                                                  fontFamily:
                                                  AppConstants.defaultFont,
                                                  fontSize:
                                                  Util.scaleWidthFromDesign(
                                                      context, 7),
                                                  fontWeight:
                                                  FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                      SizedBox(
                        width: Util.scaleWidthFromDesign(context, 10),
                      ),
                      Container(
                          width: Util.scaleWidthFromDesign(context, 50),
                          margin: EdgeInsets.only(
                              top: Util.scaleWidthFromDesign(context, 35)),

                          // color: Colors.green,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "100%",
                                  style: TextStyle(
                                      fontFamily: AppConstants.defaultFont,
                                      fontSize: Util.scaleWidthFromDesign(
                                          context, 13),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Present",
                                  style: TextStyle(
                                      fontFamily: AppConstants.defaultFont,
                                      fontSize:
                                      Util.scaleWidthFromDesign(context, 7),
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        width: Util.scaleWidthFromDesign(context, 10),
                      ),
                      Container(
                          width: Util.scaleWidthFromDesign(context, 50),
                          margin: EdgeInsets.only(
                              top: Util.scaleWidthFromDesign(context, 35)),
                          // color: Colors.green,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "0%",
                                  style: TextStyle(
                                      fontFamily: AppConstants.defaultFont,
                                      fontSize: Util.scaleWidthFromDesign(
                                          context, 13),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Away",
                                  style: TextStyle(
                                      fontFamily: AppConstants.defaultFont,
                                      fontSize:
                                      Util.scaleWidthFromDesign(context, 7),
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        width: Util.scaleWidthFromDesign(context, 10),
                      ),
                    ],
                  )),
              Container(
                alignment: Alignment.topRight,
                margin:
                EdgeInsets.only(top: Util.scaleWidthFromDesign(context, 0)),
                width: Util.scaleWidthFromDesign(context, 20),
                // color: Colors.green,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.penToSquare,
                      size: Util.scaleWidthFromDesign(context, 15),
                    )),
              ),
            ],
          ),
        ));
  }



}