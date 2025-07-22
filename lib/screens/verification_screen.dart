import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/util.dart';

class VerificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: AppBar(
                flexibleSpace: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: Util.scaleWidthFromDesign(context, 200),
                  color: Colors.white, //todo: will investigate color father
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white
                          .withAlpha(128), // Adjust opacity (0.0 to 1.0)
                      BlendMode.dstATop, // Blend the opacity with the image
                    ),
                    child:
                        Image.asset('assets/home_image.png', fit: BoxFit.cover),
                  ),
                ),
                Container(
                  child: Center(
                    child: Image.asset(
                      'assets/cooply_sm.png',
                      // Adjust how the image fits inside the box
                    ),
                  ),
                ),
              ],
            ))),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 1, top: 50),
// alignment: Alignment.center,

              child: Text(
                "Enter \nVerification Code ",
                style: TextStyle(
                    fontFamily: AppConstants.defaultFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ) ,
            OutlinedButton(
              onPressed:(){

              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                AppConstants.DashboardSideVIewDefault,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Verify',
                    style: TextStyle(
                      fontFamily: AppConstants.defaultFont,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.login),
                ],
              ),
            ),
          ],
        ));
  }
}
