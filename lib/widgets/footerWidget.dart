import 'package:flutter/cupertino.dart';

import '../utils/AppConstants.dart';
import 'simpleTextWidget.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        height: screenHeight * 0.10,
        width: screenHeight * 100,
        color: Color(0xFFE1EAD1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SimpleTextWidget(
              title: AppConstants.appVersion,
              fontFamily: AppConstants.fontFamily,
              fontWeight: FontWeight.normal,
              fontSize: 25,
            ),
            SimpleTextWidget(
              title:
                  "${AppConstants.companyName} © ${AppConstants.currentYear}",
              fontFamily: AppConstants.fontFamily,
              fontWeight: FontWeight.normal,
              fontSize: 10,
            )
          ],
        )
        //Text("Footer",textAlign: TextAlign.center,),

        );
    // TODO: implement build
  }
}
