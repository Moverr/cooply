import 'package:Cooply/cards/profile_card.dart';
import 'package:Cooply/cards/team_card.dart';
import 'package:flutter/material.dart';

import '../../../cards/account_credit_card.dart';
import '../../../cards/farm_card.dart';
import '../../../core/di/service_locator.dart';
import '../../../models/dtos/loginResponse.dart';
import '../../../services/auth_service.dart';
import '../../../utils/AppConstants.dart';
import '../../../utils/util.dart';
import '../../home_screen.dart';

class ProfileScreen extends StatefulWidget {
  final LoginResponse? loginResponse;

  const ProfileScreen({super.key, required this.loginResponse});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  String selectedValue = 'Apple';
  final List<String> dropDownItems = ['Apple', 'Banana', 'Mango', 'Orange'];

  AuthService authService = getIt<AuthService>();
  late LoginResponse loginResponse;

  @override
  void initState() {
    super.initState();
    loginResponse = widget.loginResponse!;
  }

  @override
  void dispose() {
    super.dispose();
  }

  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.white,
        child: Column(children: [
          //Profile Section
          ProfileCard(loginResponse),
          SizedBox(height: 20),

          ...(loginResponse?.roles?.any((role) => role.permissions.any(
                      (permission) =>
                          permission.resourceName == "farm" &&
                          permission.create == "ALL")) ==
                  true
              ? [FarmCard(loginResponse: loginResponse), SizedBox(height: 20)]
              : []),

          FarmCard(loginResponse: loginResponse),
          SizedBox(height: 20),
          TeamCard(),
          SizedBox(height: 20),
          AccountCreditCard(),
          SizedBox(height: 20),
          settingsCard(context),
          SizedBox(height: 70),
        ]),
      ),
    ));
  }

  Container settingsCard(BuildContext context) {
    return Container(
        height: Util.scaleWidthFromDesign(context, 110),
        width: Util.scaleWidthFromDesign(context, 320),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.black38, width: 1.0, style: BorderStyle.solid)),
        ),
        child: Container(
            // color: Colors.green,
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // White background
                  foregroundColor: Colors.black, // Black text
                  elevation: 0, // No shadow, flat design
                  side: BorderSide(color: Colors.black), // Black border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20), // Adjust the radius as needed
                  ),
                ),
                child: Text("    Logout    ",
                    style: TextStyle(
                        fontFamily: AppConstants.defaultFont,
                        fontSize: Util.scaleWidthFromDesign(context, 10))))));
  }
}
