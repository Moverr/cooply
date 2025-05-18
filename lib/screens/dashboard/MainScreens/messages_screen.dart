

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MessageState();

}

class _MessageState extends State<MessageScreen>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Text("Message Screen")

    );
  }

}