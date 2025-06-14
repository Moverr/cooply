import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/AppConstants.dart';
import '../utils/util.dart';

class HealthOverviewCard extends StatelessWidget {
  final String title;
  final String count;
  final int color;
  final String percentage;

  const HealthOverviewCard(this.title, this.count, this.color,this.percentage);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HealthOveviewCard(context,title, count, color);
  }

  Container HealthOveviewCard(BuildContext context,String title, String count, int color) {
    return Container(
        margin: EdgeInsets.all(Util.scaleWidthFromDesign(context,5)), // 👈 External spacing

        child: Container(
            // color: Colors.green.shade100,
            height: Util.scaleWidthFromDesign(context,600),
            width: Util.scaleWidthFromDesign(context,130),
            decoration: BoxDecoration(
              color: Color(color),
              borderRadius: BorderRadius.circular(Util.scaleWidthFromDesign(context,16)),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: Util.scaleWidthFromDesign(context,100),
                      width: Util.scaleWidthFromDesign(context,130),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/chickenbackground-square.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomRight: Radius.zero,
                            bottomLeft: Radius.zero),
                      ),
                    ),
                    Container(
                      height: Util.scaleWidthFromDesign(context,100),
                      width: Util.scaleWidthFromDesign(context,130),
                      decoration: BoxDecoration(
                        color: Color(color).withAlpha(120),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomRight: Radius.zero,
                            bottomLeft: Radius.zero),
                      ),
                    ),
                  ],
                ),
                Container(
                    child: Column(
                  children: [
                    Container(
                      width: Util.scaleWidthFromDesign(context,130),
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontFamily,
                            color: Colors.white,
                            fontSize: Util.scaleWidthFromDesign(context,20)),
                        softWrap: true, // Allows wrapping
                        maxLines:
                            2, // Optional: Limits to 2 lines; adjust as needed
                        overflow:
                            TextOverflow.visible, // Shows full text if possible
                        textAlign: TextAlign
                            .center, // Optional: centers text in the container
                      ),
                    ),
                    Container(
                      width: Util.scaleWidthFromDesign(context,130),
                      alignment: Alignment.center,
                      child: Text(
                        count.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontFamily,
                            color: Colors.white,
                            fontSize:Util.scaleWidthFromDesign(context,25)  ),
                        softWrap: true, // Allows wrapping
                        maxLines:
                        2, // Optional: Limits to 2 lines; adjust as needed
                        overflow:
                        TextOverflow.visible, // Shows full text if possible
                        textAlign: TextAlign
                            .center, // Optional: centers text in the container
                      ),
                    ),

                    Container(
                      width: Util.scaleWidthFromDesign(context,130),
                      alignment: Alignment.center,
                      child: Text(
                       percentage,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontFamily,
                            color: Colors.white,
                            fontSize: Util.scaleWidthFromDesign(context,15)),
                        softWrap: true, // Allows wrapping
                        maxLines:
                        2, // Optional: Limits to 2 lines; adjust as needed
                        overflow:
                        TextOverflow.visible, // Shows full text if possible
                        textAlign: TextAlign
                            .center, // Optional: centers text in the container
                      ),
                    ),

                  ],
                )
                    //Text("Register and See"),
                    )

                // Top Container


              ],
            )));
  }
}
