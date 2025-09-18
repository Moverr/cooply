import 'dart:math';

import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/dtos/flock.dart';
import '../utils/util.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:fl_chart/fl_chart.dart';

class FlockListTyle extends StatelessWidget {
  final Flock flock;
  final VoidCallback? onTap;

  FlockListTyle({Key? key, required this.flock, this.onTap}) : super(key: key);

  Container getContainerDetails(BuildContext context) {
    double progress = Util.percentOccupied(80, 100);

    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          getSummaryContainer(context),
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              minHeight: 5,
              value: progress,
              backgroundColor: Color(0xFFD0EEB5),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF1C1A5)),
            ),
          ),
          getBreedStageSummaryContainer(context),
          SizedBox(
            height: 10,
          ),
          getFeedConsumptionWidget(),
          SizedBox(
            height: 10,
          ),
          getWaterConsumptionWidget(),
          SizedBox(
            height: 10,
          ),
          getHealthWidget(),
          SizedBox(
            height: 10,
          ),


          SizedBox(
            height: 30,
          ),
        ]));
  }

  ExpansionTile getFeedConsumptionWidget() {
    return ExpansionTile(
            childrenPadding: EdgeInsets.all(20),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 8),
                const Text(
                  "Feed Consumption  : 1.2 Tonnes ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            collapsedBackgroundColor: Colors.green[50],
            backgroundColor: Colors.green[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        recordRowItem("Total :"," 1,200 KG "),
                        recordRowItem("Last Consumption  :"," 1000KG "),
                        recordRowItem("Last Daily / Bird  :"," 1000KG "),
                        recordRowItem("Average  Daily  :"," 1000KG "),
                        recordRowItem("Average / Bird  :"," 1000KG "),
                        recordRowItem("Daily Comsumption   :"," 1000KG "),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    // color: Colors.red,
                    width: 220,
                    height: 150,
                    child: Center(
                      child: SizedBox(
                        height: 300,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: LineChart(
                              sampleData(),
                              // swapAnimationDuration: Duration(milliseconds: 400),
                            ),
                          ),
                        ),
                      ),
                  ),
                  ),
                ],

              )
            ]);
  }

  ExpansionTile getWaterConsumptionWidget() {
    return ExpansionTile(
        childrenPadding: EdgeInsets.all(20),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            const Text(
              "Water Consumption : 2000 LTRs ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
        collapsedBackgroundColor: Colors.blue[50],
        backgroundColor: Colors.blue[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    recordRowItem("Total :"," 1,200 LTRs "),
                    recordRowItem("Last Consumption  :"," 1000 LTRs "),
                    recordRowItem("Last Daily / Bird  :"," 1000 LTRs "),
                    recordRowItem("Average  Daily  :"," 1000 LTRs "),
                    recordRowItem("Average / Bird  :"," 1000 LTRs"),
                    recordRowItem("Daily Comsumption   :"," 1000 LTRs "),
                  ],
                ),
              ),
              Spacer(),
              Container(
                // color: Colors.red,
                width: 220,
                height: 160,
                child: Center(
                  child: SizedBox(
                    height: 300,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: LineChart(
                          sampleData(),
                          // swapAnimationDuration: Duration(milliseconds: 400),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],

          )
        ]);
  }

  ExpansionTile getHealthWidget() {
    return ExpansionTile(
        childrenPadding: EdgeInsets.all(20),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            const Text(
              "Health   ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
        collapsedBackgroundColor: Color(0XFFF4F4F4),
        backgroundColor: Color(0XFFF4F4F4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Vacc : ", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),),
                        Text("80%", style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12,
                        ),),

                        Text(" Mor : ", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),),
                        Text("70", style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12,
                        ),),


                        Text(" Sick : ", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12,
                        ),),
                        Text("12", style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12,
                        ),),


                      ],
                    )
                    ,
                    recordRowItem(" General Health :"," OK "),
                    recordRowItem(" Treatments :"," Herbal,Coryza .. "),
                    recordRowItem(" Next Vacc  :"," Mareks , 12th.05 "),
                    recordRowItem(" Missed Vacc  :"," Coryza"),
                  ],
                ),
              ),
              Spacer(),
              Container(
                // color: Colors.red,
                width: 200,
                height: 100,
                child: Center(
                  child: SizedBox(
                    height: 300,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: LineChart(
                          sampleData(),
                          // swapAnimationDuration: Duration(milliseconds: 400),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],

          )
        ]);
  }



  Container getSummaryContainer(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        // color: Colors.green,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      "Batch : ",
                      style: TextStyle(
                          fontFamily: AppConstants.defaultFont,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "  2024.01.02 : 2782272822722282",
                      style: TextStyle(
                          fontFamily: AppConstants.defaultFont,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/chicken.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.orange, // your desired color
                        BlendMode
                            .srcIn, // keeps the shape and applies the color
                      ),
                    ),
                    Tooltip(
                      message: "Acquired Flock",
                      child: Text(
                        " Acq : 12K",
                        style: TextStyle(
                            fontFamily: AppConstants.defaultFont,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      'assets/svg/chicken.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.greenAccent.shade700, // your desired color
                        BlendMode
                            .srcIn, // keeps the shape and applies the color
                      ),
                    ),
                    Tooltip(
                      message: "Available Flock",
                      child: Text(
                        " Avail : 10K",
                        style: TextStyle(
                            fontFamily: AppConstants.defaultFont,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      'assets/svg/chicken.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.redAccent.shade100, // your desired color
                        BlendMode
                            .srcIn, // keeps the shape and applies the color
                      ),
                    ),
                    Tooltip(
                      message: "Mortality ",
                      child: Text(
                        "Mor : 20",
                        style: TextStyle(
                            fontFamily: AppConstants.defaultFont,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      'assets/svg/chicken.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.red.shade500, // your desired color
                        BlendMode
                            .srcIn, // keeps the shape and applies the color
                      ),
                    ),
                    Tooltip(
                      message: "Sick Birds ",
                      child: Text(
                        "Sick : 30",
                        style: TextStyle(
                            fontFamily: AppConstants.defaultFont,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      'assets/svg/cashin.svg',
                      width: 20,
                      height: 20,
                    ),
                    Tooltip(
                      message: "Sold Birds",
                      child: Text(
                        "20",
                        style: TextStyle(
                            fontFamily: AppConstants.defaultFont,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),

              //  double progress =
              //         Util.percentOccupied(coop.occupied ?? 0, coop.capacity ?? 0);
              //
            ]),
            Spacer(),
            Container(
              alignment: Alignment.topCenter,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.penToSquare,
                  size: Util.scaleWidthFromDesign(context, 12),
                ),
              ),
            ),
          ],
        ));
  }


  Container getBreedStageSummaryContainer(BuildContext context) {
    return     Container(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Text(
            "Breed : ",
            style: TextStyle(
                fontFamily: AppConstants.defaultFont,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          ),
          Text(
            "  Sasso",
            style: TextStyle(
                fontFamily: AppConstants.defaultFont,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          ),

          SizedBox(width: 10,),

          Text(
            "Stage : ",
            style: TextStyle(
                fontFamily: AppConstants.defaultFont,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          ),
          Text(
            "  Grower",
            style: TextStyle(
                fontFamily: AppConstants.defaultFont,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(width: 10,),

          Text(
            "Week : ",
            style: TextStyle(
                fontFamily: AppConstants.defaultFont,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          ),
          Text(
            "  26",
            style: TextStyle(
                fontFamily: AppConstants.defaultFont,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          ),






        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return getContainerDetails(context);

    // return GestureDetector(
    //   onTap: onTap,
    //   child:

    /*
      Container(
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
          child:
          
          
         Wrap(
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
          )

          ),

    );

           */
  }


  LineChartData sampleData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.2),
          strokeWidth: 1,
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.12),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, interval: 2),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              final labels = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
              final index = value.toInt();
              if (index >= 0 && index < labels.length) {
                return Text(labels[index], style: const TextStyle(fontSize: 9));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 10,

      /// ✨ Touch + Tooltip configuration (new API)
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding: const EdgeInsets.all(8),
          tooltipMargin: 8,
          tooltipBorderRadius: BorderRadius.all(Radius.circular(0)),
          tooltipBorder: const BorderSide(color: Colors.white, width: 1),
          getTooltipColor: (spots) => Colors.black87,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                'Day ${spot.x.toInt()} : ${spot.y}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),

      /// ✨ Line chart data
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 10),
            FlSpot(1, 8),
            FlSpot(2, 6),
            FlSpot(3, 5),
            FlSpot(4, 8),
            FlSpot(5, 7),
            FlSpot(6, 8),
          ],
          isCurved: true,
          barWidth: 3,
          dotData: FlDotData(show: true),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.green.withOpacity(0.3),
                Colors.blue.withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }


  Container recordRowItem(String title, String record) {
    return Container(
      padding: EdgeInsets.only(top: 3,bottom: 3),
        child: Row(
          children: [
            Text(title, style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 12,
            ),),
            Text(record, style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 12,
            ),)
          ],
        )

    );
  }

}
