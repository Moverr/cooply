

import 'dart:core';

import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/material.dart';

class LoadingDialog{



  static void show(BuildContext context,String information){
    showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
      return AlertDialog(
        content: Row(
          children: [
            // CircularProgressIndicator(),
            RefreshProgressIndicator(),
            // LinearProgressIndicator(),
            SizedBox(width: 16,),// width and height
            Text(information,style: TextStyle(fontFamily:AppConstants.defaultFont,fontSize: 12,
              fontWeight:FontWeight.w500,

            ) ,)


          ],
        ),
      );
      }
    );
  }


  static void hide(BuildContext context){
    if(Navigator.of(context).canPop()){
      Navigator.of(context).pop();
    }
  }

}