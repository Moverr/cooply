

import 'package:flutter/cupertino.dart';

class SimpleTextWidget extends StatelessWidget {

  final  String title;
  final String fontFamily;
  final FontWeight fontWeight;
  final double fontSize;

  const SimpleTextWidget({
    super.key,
    required this.title,
    required this.fontFamily , // Provide a default font family
    required this.fontWeight,
    required this.fontSize
  });



  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(fontFamily:fontFamily,fontSize: fontSize,
      fontWeight:fontWeight,

    ), );
  }
}


