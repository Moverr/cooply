import 'package:Cooply/screens/register_screen.dart';
import 'package:flutter/material.dart';

import '../utils/AppConstants.dart';
import '../widgets/footerWidget.dart';
import '../widgets/simpleTextWidget.dart';
import 'login_screen.dart';

// @movers
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double offsetScreen = screenHeight * 0.12;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: AppBar(
                // title: Text("Mawae"),
                flexibleSpace: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color:
                      Color(0xFFFFFFFF), //todo: will investigate color father
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withAlpha(128), // Adjust opacity (0.0 to 1.0)
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
        body: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                ),
                child: TabBar(
                  labelColor: Colors.black, // Active tab color
                  unselectedLabelColor: Colors.black, // Inactive tab color
                  indicatorColor: Colors.white, // Color of the indicator line
                  indicatorWeight: 3.0, // Thickness of the indicator line
                  labelPadding: EdgeInsets.symmetric(
                      horizontal: 20.0), // Padding for the label
                  tabs: [
                    Tab(
                      child: SimpleTextWidget(
                        title: AppConstants.LOGIN,
                        fontFamily: AppConstants.fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 16, // Adjust font size for better readability
                        // color: Color(0xFF000000), // Text color
                      ),
                    ),
                    Tab(
                      child: SimpleTextWidget(
                        title: AppConstants.SIGNUP_LOGIN,
                        fontFamily: AppConstants.fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        // color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(children: [


                    LoginScreen(),
                // LoginScreen(),
                RegisterForm(),
              ])),
              FooterWidget()
            ],
          ),
        ));
  }
}
