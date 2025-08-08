

import 'package:Cooply/models/dtos/loginResponse.dart';
import 'package:flutter/cupertino.dart';

import '../utils/AppConstants.dart';
import '../utils/util.dart';

class ProfileCard extends StatefulWidget{
   final LoginResponse loginResponse;

   ProfileCard(this.loginResponse);
  @override
  State<StatefulWidget> createState()  => _ProfileCardState();

}

class _ProfileCardState extends State<ProfileCard>{
  late LoginResponse loginResponse;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginResponse = widget.loginResponse;

  }
  @override
  Widget build(BuildContext context)  => profileCard(context);




  Container profileCard(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: Util.scaleWidthFromDesign(context, 30)),

                // color: Colors.red,
                height: Util.scaleWidthFromDesign(context, 50),
                alignment: Alignment.center,
                width: double.infinity,
                //Util.scaleWidthFromDesign(context, 100),
                // child: Text("Profile Section"),
              ),

              // Profile container (goes out of parent)
              Positioned(
                top: Util.scaleWidthFromDesign(
                    context, 0), // Negative value to go outside
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding:
                    EdgeInsets.all(Util.scaleWidthFromDesign(context, 14)),
                    width: Util.scaleWidthFromDesign(context, 80),
                    height: Util.scaleWidthFromDesign(context, 80),

                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10),
                      color: Color(0XFFD9D9D9),
                      /*
                      boxShadow: [
                        BoxShadow(
                          color: Color(0XFFD9D9D9),
                          blurRadius: Util.scaleWidthFromDesign(context, 5),
                          offset: Offset(
                              Util.scaleWidthFromDesign(context, 0),
                              Util.scaleWidthFromDesign(context, 3)),
                        ),
                      ],

                      */
                    ),

                    child: Image.asset(
                      'assets/defaultprofileimage.png',
                      fit: BoxFit.cover,
                      width: Util.scaleWidthFromDesign(context, 60),
                    ),
                    //assets/defaultprofileimage.png
                  ),
                ),
              ),
            ],
          ),
          Text(
           loginResponse.username,
            style: TextStyle(
                fontSize: Util.scaleWidthFromDesign(context, 16),
                fontFamily: AppConstants.defaultFont),
          ),
          Text(
            "PROJECT OWNER",
            style: TextStyle(
                fontSize: Util.scaleWidthFromDesign(context, 8),
                fontFamily: AppConstants.defaultFont),
          ), //Role
          Text(
            "📞 0779820962",
            style: TextStyle(
                fontSize: Util.scaleWidthFromDesign(context, 8),
                fontFamily: AppConstants.defaultFont),
          ),
          Text(
            " ✉️ moverr@gmail.com",
            style: TextStyle(
                fontSize: Util.scaleWidthFromDesign(context, 8),
                fontFamily: AppConstants.defaultFont),
          ),
        ],
      ),
    );
  }


}
