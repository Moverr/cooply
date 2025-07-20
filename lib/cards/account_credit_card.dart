


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/AppConstants.dart';
import '../utils/util.dart';

class AccountCreditCard extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _AccountCreditCardState();
  
}

class _AccountCreditCardState extends State<AccountCreditCard>{
  @override
  Widget build(BuildContext context) => accountCreditCard(context);


  Container accountCreditCard(BuildContext context) {
    return Container(
        height: Util.scaleWidthFromDesign(context, 110),
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
                          width: Util.scaleWidthFromDesign(context, 150),
                          // color: Colors.green,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Accounts & Credits",
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
                                              "Current package ",
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
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Free Tier",
                                                  style: TextStyle(
                                                      fontFamily: AppConstants
                                                          .defaultFont,
                                                      fontSize: Util
                                                          .scaleWidthFromDesign(
                                                          context, 13),
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: Util.scaleWidthFromDesign(
                                                      context, 15) ,
                                                  height: Util.scaleWidthFromDesign(
                                                      context, 15) ,
                                                  color: Color(0XFF8AD184),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Switch Package ",
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
                                          Container(
                                            margin: EdgeInsets.only(bottom: 2),
                                            alignment: Alignment.topLeft,
                                            child: SizedBox(
                                                width: Util.scaleWidthFromDesign(
                                                    context, 110),
                                                child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: Colors
                                                          .white, // White background
                                                      foregroundColor: Colors
                                                          .black, // Black text
                                                      elevation:
                                                      0, // No shadow, flat design
                                                      side: BorderSide(
                                                          color: Colors
                                                              .black), // Black border
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20), // Adjust the radius as needed
                                                      ),
                                                    ),
                                                    child: Text("UPGRADE",
                                                        style: TextStyle(
                                                            fontFamily:
                                                            AppConstants
                                                                .defaultFont,
                                                            fontSize: Util.scaleWidthFromDesign(
                                                                context, 10))))),
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
                        // color: Colors.black38,
                          width: Util.scaleWidthFromDesign(context, 120),
                          margin: EdgeInsets.only(
                              top: Util.scaleWidthFromDesign(context, 20)),

                          // color: Colors.green,
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0XFF8AD184),
                                          borderRadius: BorderRadius.all( Radius.circular(10)),
                                        ),
                                        width: Util.scaleWidthFromDesign(
                                            context, 15)  ,
                                        height: Util.scaleWidthFromDesign(
                                            context, 15)  ,

                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Free Tier",
                                        style: TextStyle(
                                            fontSize: Util.scaleWidthFromDesign(
                                                context, 9),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                            AppConstants.defaultFont),
                                      ),
                                      SizedBox(
                                        width: Util.scaleWidthFromDesign(
                                            context, 3),
                                      ),
                                      Text(
                                        "Current",
                                        style: TextStyle(
                                            fontSize: Util.scaleWidthFromDesign(
                                                context, 8),
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                            AppConstants.defaultFont),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: Util.scaleWidthFromDesign(
                                    context, 1),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0XFFA139FA),
                                          borderRadius: BorderRadius.all( Radius.circular(10)),
                                        ),
                                        width: Util.scaleWidthFromDesign(
                                            context, 15)  ,
                                        height: Util.scaleWidthFromDesign(
                                            context, 15)  ,

                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Platinum",
                                        style: TextStyle(
                                            fontSize: Util.scaleWidthFromDesign(
                                                context, 9),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                            AppConstants.defaultFont),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: Util.scaleWidthFromDesign(
                                    context, 1),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0XFF3760ED),
                                          borderRadius: BorderRadius.all( Radius.circular(10)),
                                        ),

                                        width: Util.scaleWidthFromDesign(
                                            context, 15)  ,
                                        height: Util.scaleWidthFromDesign(
                                            context, 15)  ,

                                      ),
                                      SizedBox(
                                        width: Util.scaleWidthFromDesign(
                                            context, 3),
                                      ),
                                      Text(
                                        "Silver",
                                        style: TextStyle(
                                            fontSize: Util.scaleWidthFromDesign(
                                                context, 9),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                            AppConstants.defaultFont),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: Util.scaleWidthFromDesign(
                                    context, 1),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0XFFDFB32B),
                                          borderRadius: BorderRadius.all( Radius.circular(10)),
                                        ),
                                        width: Util.scaleWidthFromDesign(
                                            context, 15)  ,
                                        height: Util.scaleWidthFromDesign(
                                            context, 15)  ,


                                      ),
                                      SizedBox(
                                        width: Util.scaleWidthFromDesign(
                                            context, 3),
                                      ),
                                      Text(
                                        "Gold",
                                        style: TextStyle(
                                            fontSize: Util.scaleWidthFromDesign(
                                                context, 9),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                            AppConstants.defaultFont),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: Util.scaleWidthFromDesign(
                                    context, 1),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0XFFBD4638),
                                          borderRadius: BorderRadius.all( Radius.circular(10)),
                                        ),
                                        width:  Util.scaleWidthFromDesign(
                                            context, 15),
                                        height:  Util.scaleWidthFromDesign(
                                            context, 15),

                                      ),
                                      SizedBox(
                                        width: Util.scaleWidthFromDesign(
                                            context, 3),
                                      ),
                                      Text(
                                        "Premium",
                                        style: TextStyle(
                                            fontSize: Util.scaleWidthFromDesign(
                                                context, 9),
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                            AppConstants.defaultFont),
                                      ),
                                    ],
                                  )),
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