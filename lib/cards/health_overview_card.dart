import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/AppConstants.dart';

class HealthOverviewCard extends StatelessWidget {
  final String title;
  final String count;
  final int color;
  final String percentage;

  const HealthOverviewCard(this.title, this.count, this.color,this.percentage);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HealthOveviewCard(title, count, color);
  }

  Container HealthOveviewCard(String title, String count, int color) {
    return Container(
        margin: EdgeInsets.all(5), // 👈 External spacing

        child: Container(
            // color: Colors.green.shade100,
            height: 600,
            width: 130,
            decoration: BoxDecoration(
              color: Color(color),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 130,
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
                      height: 100,
                      width: 130,
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
                      width: 130,
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontFamily,
                            color: Colors.white,
                            fontSize: 20),
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
                      width: 130,
                      alignment: Alignment.center,
                      child: Text(
                        count.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontFamily,
                            color: Colors.white,
                            fontSize: 25),
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
                      width: 130,
                      alignment: Alignment.center,
                      child: Text(
                       percentage,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontFamily,
                            color: Colors.white,
                            fontSize: 15),
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

                /*
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 300,
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/chicenbackground.png'), // Ensure image is in pubspec.yaml
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Color(color).withAlpha(120),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center, // ✅ Vertical centering
                        crossAxisAlignment:
                        CrossAxisAlignment.center, // ✅ Horizontal centering

                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              count.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppConstants.fontFamily,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppConstants.fontFamily,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                */
              ],
            )));
  }
}
