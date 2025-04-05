
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                horizontal: 16,
                vertical: 20), // Adjust padding as needed

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),

              // Removes border radius
            ),
          ),
          child: Row(
            mainAxisSize:
            MainAxisSize.min, // Prevents excessive button width
            children: [
              Image.asset(
                "assets/google.png",
                height: 24,
                width: 24,
              ),
              // Replace with your desired icon
            ],
          ),
        ),
        const SizedBox(width: 20),
        OutlinedButton(
          onPressed: handleAuth2,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20), // Adjust padding as needed

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),

              // Removes border radius
            ),
          ),
          child: Row(
            mainAxisSize:
            MainAxisSize.min, // Prevents excessive button width
            children: [
              Image.asset(
                "assets/x.png",
                height: 24,
                width: 24,
              ),
              // Replace with your desired icon
            ],
          ),
        ),
        const SizedBox(width: 20),
        OutlinedButton(
          onPressed: handleAuth2,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20), // Adjust padding as needed

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),

              // Removes border radius
            ),
          ),
          child: Row(
            mainAxisSize:
            MainAxisSize.min, // Prevents excessive button width
            children: [
              Image.asset(
                "assets/facebook.png",
                height: 24,
                width: 24,
              ),
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