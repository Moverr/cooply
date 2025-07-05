import 'dart:collection';

import 'package:Cooply/models/dtos/schedule.dart';
import 'package:Cooply/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/AppConstants.dart';

class ScheduleCard extends StatelessWidget{

  final Schedule schedule;


  ScheduleCard(   this.schedule);




  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      // color: Colors.black38,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: Util.scaleWidthFromDesign(context,90),
            padding: EdgeInsets.all(5),
            // color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only( left:  Util.scaleWidthFromDesign(context,10),top:  Util.scaleWidthFromDesign(context,10),right:  Util.scaleWidthFromDesign(context,10)),
                  alignment: Alignment.center,
                  child: Text(Util.getDayWithSuffix(schedule.scheduleDate),style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,20),fontWeight: FontWeight.normal,color: Color(Util.getStatusColor(schedule.status)) ),
                  ),
                ),
                Container(

                  padding: EdgeInsets.all( Util.scaleWidthFromDesign(context,10)) ,
                  decoration: BoxDecoration(
                    color:Color(Util.getStatusColor(schedule.status)) ,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular( Util.scaleWidthFromDesign(context,20)),bottomRight: Radius.circular( Util.scaleWidthFromDesign(context,20))), // 👈 Rounded corners
                    border: Border.all(color: Color(Util.getStatusColor(schedule.status)) ),  // Optional border
                  ),
                  alignment: Alignment.center,
                  child: Text(Util.getMonthYearFormatted(schedule.scheduleDate),style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize: 10,fontWeight: FontWeight.normal,color: Colors.white),),
                )

              ],
            ),
          ),
          Container(
            width:  Util.scaleWidthFromDesign(context,206),
            padding: EdgeInsets.all( Util.scaleWidthFromDesign(context,5)),
            // color: Colors.white,
            child: Column(

              children: [

                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("🏡 : ",style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(schedule.farm,style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),

                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("🏠 : ",style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(schedule.coop,style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),

                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("📋 : ",style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(schedule.type,style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),


                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("⏰ : ",style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.bold,color: Colors.black),
                          overflow: TextOverflow.ellipsis, // or TextOverflow.fade
                          maxLines: 1,
                        ),
                        Text(Util.formatSmartRange(schedule.from,schedule.to),style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.normal,color: Colors.black38), overflow: TextOverflow.ellipsis, // or TextOverflow.fade
                          maxLines: 1,),

                      ],
                    )
                ),

                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("⚠️ : ",style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(schedule.priority,style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),


                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("👤 : ",style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(schedule.assignedTo,style: TextStyle(fontFamily: AppConstants.defaultFont,fontSize:  Util.scaleWidthFromDesign(context,13),fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),






              ],
            ),
          ),
          Container( //todo: icons
            width:  Util.scaleWidthFromDesign(context,40),
            height: Util.scaleWidthFromDesign(context,150),
            // color: Colors.red.shade300,
            child: Column(
              children: [
                Container(
                  // padding: EdgeInsets.only( left: 10,top: 10,right: 10),
                  alignment: Alignment.center,
                  child:  Container(
                    height:  Util.scaleWidthFromDesign(context,80),
                    // color: Colors.blue,
                    alignment: Alignment.topRight,
                    child: IconButton(onPressed: (){

                    }, icon: Icon( FontAwesomeIcons.penToSquare,size:  Util.scaleWidthFromDesign(context,20),)
                    ),
                  ),
                  //Text("Ask",style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green.shade400),

                ),

                Container(

                    alignment: Alignment.bottomCenter,
                    child:  Text(schedule.status.name.toUpperCase(),style: TextStyle(fontSize:  Util.scaleWidthFromDesign(context,5),color: Color(Util.getStatusColor(schedule.status)) ,fontWeight: FontWeight.bold),)
                  //Text("Ask",style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green.shade400),

                ),


              ],
            ),
          ),
        ],
      ),
    );

  }
  
}