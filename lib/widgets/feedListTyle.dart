import 'dart:math';

import 'package:Cooply/models/dtos/coop.dart';
import 'package:Cooply/models/dtos/farm.dart';
import 'package:Cooply/models/dtos/feed_inventory.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:data_table_2/data_table_2.dart';

import '../models/dtos/flock.dart';
import '../utils/util.dart';



class FeedListTyle extends StatelessWidget {
  final FeedInventory feed;
  final VoidCallback? onTap;

  FeedListTyle({Key? key, required this.feed, this.onTap}) : super(key: key);

  final List<Map<String, dynamic>> transactions = [
    {
      "item": "Maize",
      "transactionType": "sub",
      "quantity": 100,
      "available_quantity": 100,
      "timestamp": "2025-05-25"
    },
    {
      "item": "Brand",
      "transactionType": "sub",
      "quantity": 30,
      "available_quantity": 100,
      "timestamp": "2025-05-26"
    },
    {
      "item": "Lime",
      "transactionType": "add",
      "quantity": 20,
      "available_quantity": 100,
      "timestamp": "2025-05-27"
    },
    {
      "item": "Soya Bean",
      "transactionType": "add",
      "quantity": 100,
      "available_quantity": 100,
      "timestamp": "2025-05-25"
    },
    {
      "item": "Sun Flower",
      "transactionType": "sub",
      "quantity": 30,
      "available_quantity": 100,
      "timestamp": "2025-05-26"
    },
    {
      "item": "DCP",
      "transactionType": "add",
      "quantity": 20,
      "available_quantity": 100,
      "timestamp": "2025-05-27"
    },
    {
      "item": "Maize",
      "transactionType": "sub",
      "quantity": 100,
      "available_quantity": 100,
      "timestamp": "2025-05-25"
    },
    {
      "item": "Cassava Flour",
      "transactionType": "sub",
      "quantity": 30,
      "timestamp": "2025-05-26"
    },
    {
      "item": "Cassava Flour",
      "transactionType": "add",
      "quantity": 20,
      "available_quantity": 100,
      "timestamp": "2025-05-27"
    },
    {
      "item": "Cassava ",
      "transactionType": "add",
      "quantity": 100,
      "available_quantity": 100,
      "timestamp": "2025-05-25"
    },

  ];


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
          // height: 250,
          constraints: BoxConstraints(
            minHeight: 200, // set your minimum height here
          ),

          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
              boxShadow:   [
              BoxShadow(
              color: Color(0XFFCDB4B4),
        blurRadius:  Util.scaleWidthFromDesign(context,1),
        offset: Offset( Util.scaleWidthFromDesign(context,0),  Util.scaleWidthFromDesign(context,3)),
      ),],
          ),
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                // constraints: BoxConstraints(
                //   minHeight: 200, // set your minimum height here
                // ),
                // height: 135,
                width: 410,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "BN : ${feed.batchId}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Date Registered : ${feed.registeredDate!}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Quantity Added :  ${feed.quantity} ",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Quantity Removed :  ${feed.quantity} ",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Quantity Available :  ${feed.quantity} ",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppConstants.defaultFont),
                      ),
                    ),



                    Container(
                        constraints: BoxConstraints(
                          minHeight: 200, // set your minimum height here
                        ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        //todo: Make datatable sortable
                        child:    DataTable(

                          columns: const [
                            DataColumn(label: Text("Item")),
                            DataColumn(label: Text("Quantity")),
                            DataColumn(label: Text("Type")),
                            DataColumn(label: Text("Total")),
                            // DataColumn(label: Text("Date")),
                          ],

                          rows: transactions.map((tx) {

                            return DataRow(

                                cells: [
                              DataCell(Text(tx['item'])),
                              DataCell(Text(tx['quantity'].toString())),
                              DataCell(Text(tx['transactionType'])),
                              DataCell(Text(tx['available_quantity'].toString())),


                            ]);
                          }).toList(),
                          // headingRowHeight: 56,
                          // dataRowHeight: 48,
                          // columnSpacing: 12,
                          // horizontalMargin: 12,
                          // : 600,

                        ),
                      )

                    )


                  ],
                ),
              ),

            ],
          )),
    );
  }

  List<String> images = [
    "assets/chicken1.png",
    "assets/chicken2.png",
    "assets/chicken3.png",
    "assets/chicken4.png",
    "assets/chicken5.png",
    "assets/chicken6.png",
    "assets/chicken7.png",
  ];
  final random = Random();
  Image getRandomImage() {
    int number = random.nextInt(7);
    return Image.asset(images[number]);
  }
}
