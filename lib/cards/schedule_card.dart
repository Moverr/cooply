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
      height: 150,
      width: double.infinity,
      // color: Colors.black38,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: 150,
            height:150,
            padding: EdgeInsets.all(5),
            // color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only( left: 10,top: 10,right: 10),
                  alignment: Alignment.center,
                  child: Text(Util.getDayWithSuffix(schedule.scheduleDate),style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 50,fontWeight: FontWeight.normal,color: Color(Util.getStatusColor(schedule.status)) ),
                  ),
                ),
                Container(

                  padding: EdgeInsets.all(10) ,
                  decoration: BoxDecoration(
                    color:Color(Util.getStatusColor(schedule.status)) ,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)), // 👈 Rounded corners
                    border: Border.all(color: Color(Util.getStatusColor(schedule.status)) ),  // Optional border
                  ),
                  alignment: Alignment.center,
                  child: Text(Util.getMonthYearFormatted(schedule.scheduleDate),style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 17,fontWeight: FontWeight.normal,color: Colors.white),),
                )

              ],
            ),
          ),
          Container(
            width: 310,
            height:150,
            padding: EdgeInsets.all(5),
            // color: Colors.white,
            child: Column(

              children: [

                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("🏡Farm : ",style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(schedule.farm,style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),

                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("🏠 Coop : ",style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(schedule.coop,style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),

                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("📋 Type : ",style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(schedule.type,style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),


                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("⏰ Duration : ",style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(Util.formatSmartRange(schedule.from,schedule.to),style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),

                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("⚠️ Priority : ",style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(schedule.priority,style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),


                Container(
                    alignment: Alignment.topLeft,
                    child:  Row(
                      children: [
                        Text("👤 Assigned : ",style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black),),
                        Text(schedule.assignedTo,style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 13,fontWeight: FontWeight.normal,color: Colors.black38),),

                      ],
                    )
                ),






              ],
            ),
          ),
          Container( //todo: icons
            width: 80,
            height:150,
            // color: Colors.red.shade300,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only( left: 10,top: 10,right: 10),
                  alignment: Alignment.center,
                  child:  Container(
                    height: 80,
                    // color: Colors.blue,
                    alignment: Alignment.topRight,
                    child: IconButton(onPressed: (){

                    }, icon: Icon( FontAwesomeIcons.penToSquare,size: 15,)
                    ),
                  ),
                  //Text("Ask",style: TextStyle(fontFamily: AppConstants.fontFamily,fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green.shade400),

                ),

                Container(

                    alignment: Alignment.bottomCenter,
                    child:  Text(schedule.status.name.toUpperCase(),style: TextStyle(fontSize: 10,color: Color(Util.getStatusColor(schedule.status)) ,fontWeight: FontWeight.bold),)
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