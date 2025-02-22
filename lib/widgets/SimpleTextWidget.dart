

import 'package:flutter/cupertino.dart';

class SimpleTextWidget extends StatelessWidget {

  final  String title;
  final String fontFamily;
  final FontWeight fontWeight;
  final double fontSize;

  SimpleTextWidget({
    Key? key,
    required this.title,
    required this.fontFamily , // Provide a default font family
    required this.fontWeight,
    required this.fontSize
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Text(this.title,style: TextStyle(fontFamily:this.fontFamily,fontSize: this.fontSize, fontWeight:this.fontWeight,),);
  }
}


