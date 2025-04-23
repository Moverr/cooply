
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Auth2RowWidget extends StatelessWidget {


  /**
   *
   * This WIdget will handle Auth 2 implementation, from different platforms
   */
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.center, // Spaces items evenly
      crossAxisAlignment:
      CrossAxisAlignment.center, // Centers items vertically
      children: [
        OutlinedButton(
          onPressed: handleAuth2,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10), // Adjust padding as needed

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),

              // Removes border radius
            ),
          ),
          child: Row(
            mainAxisSize:
            MainAxisSize.min, // Prevents excessive button width
            children: [

              IconButton(
                  onPressed: null, icon: FaIcon(FontAwesomeIcons.google)
                  ,iconSize:18 ,
              )
              // Image.asset(
              //   "assets/google.png",
              //   height: 24,
              //   width: 24,
              // ),
              // Replace with your desired icon
            ],
          ),
        ),
        const SizedBox(width: 20),
        OutlinedButton(
          onPressed: handleAuth2,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10), // Adjust padding as needed

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),

              // Removes border radius
            ),
          ),
          child: Row(
            mainAxisSize:
            MainAxisSize.min, // Prevents excessive button width
            children: [
              IconButton(
                onPressed: null, icon: FaIcon(FontAwesomeIcons.x)
                ,iconSize:18 ,
              )
              // Replace with your desired icon
            ],
          ),
        ),
        const SizedBox(width: 20),
        OutlinedButton(
          onPressed: handleAuth2,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10), // Adjust padding as needed

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),

              // Removes border radius
            ),
          ),
          child: Row(
            mainAxisSize:
            MainAxisSize.min, // Prevents excessive button width
            children: [
              IconButton(
                onPressed: null, icon: FaIcon(FontAwesomeIcons.facebook)
                ,iconSize:18 ,
              )
              // Replace with your desired icon
            ],
          ),
        ),
      ],
    );


  }


  handleAuth2(){

  }


}