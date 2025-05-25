import 'dart:math';

import 'package:Cooply/models/dtos/coop.dart';
import 'package:Cooply/models/dtos/farm.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/dtos/flock.dart';

class FeedListTyle extends StatelessWidget {
  final Flock flock;
  final VoidCallback? onTap;

  FeedListTyle({Key? key, required this.flock, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 250,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0XFFCDB4B4),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                height: 125,
                width: 200,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "BN : ${flock.batchName}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Acquired : ${flock.acquiredOn!}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Type : ${flock.type}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Current Stock : ${flock.currentBirdCount}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Stock : ${flock.stock}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.fontFamily),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mortality : ${flock.mortality}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.fontFamily),
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
                      height: 80,
                      // color: Colors.blue,
                      alignment: Alignment.topRight,
                      child: IconButton(onPressed: (){

                      }, icon: Icon( FontAwesomeIcons.penToSquare)
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child:Text(
                        "${flock.status!.toUpperCase()}",
                        style: const TextStyle(fontSize: 10,fontWeight: FontWeight.normal),
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
