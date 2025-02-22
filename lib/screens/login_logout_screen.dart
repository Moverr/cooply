import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginLogoutScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return
   Container(
   child:
     Transform.translate(
     offset: Offset(0, -45),
     child: DefaultTabController(
       length: 2,
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Container(
             decoration: BoxDecoration(
               color: Colors.blue,
               borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
             ),
             child: TabBar(
               labelColor: Colors.white,
               unselectedLabelColor: Colors.white70,
               indicatorColor: Colors.white,
               tabs: [
                 Tab(text: "LOGIN"),
                 Tab(text: "SIGN UP"),
               ],
             ),


           ),
        TabBarView(children: [
Center(child: Text("Jinja"),),
              Center(child: Text("Entebbe"),)
              
            ]),



         ],
       ),
     ),

     )
   );


  }

}