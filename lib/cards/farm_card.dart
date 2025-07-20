import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/AppConstants.dart';
import '../utils/util.dart';

class FarmCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FarmCardState();
}

class _FarmCardState extends State<FarmCard> {
  final List<String> dropDownItems = ['Apple', 'Banana', 'Mango', 'Orange'];

  @override
  Widget build(BuildContext context) => farmCard(context);

  Container farmCard(BuildContext context) {
    return Container(
        height: Util.scaleWidthFromDesign(context, 100),
        width: Util.scaleWidthFromDesign(context, 320),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.black38, width: 1.0, style: BorderStyle.solid)),
        ),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                // color: Colors.red,
                child: Wrap(
                  children: [
                    Container(
                        width: Util.scaleWidthFromDesign(context, 160),
                        // color: Colors.green,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Farms",
                                style: TextStyle(
                                    fontFamily: AppConstants.defaultFont,
                                    fontSize:
                                        Util.scaleWidthFromDesign(context, 13),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: [
                                    Wrap(
                                      //farm card
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Current Farm  ",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppConstants.defaultFont,
                                                fontSize:
                                                    Util.scaleWidthFromDesign(
                                                        context, 7),
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Mwamba  Farm",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppConstants.defaultFont,
                                                fontSize:
                                                    Util.scaleWidthFromDesign(
                                                        context, 12),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          // color: Colors.red,
                                          width: Util.scaleWidthFromDesign(
                                              context, 120),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownSearch<String>(
                                              items: dropDownItems,
                                              popupProps: PopupProps.menu(
                                                // showSearchBox: true,
                                                searchFieldProps:
                                                    TextFieldProps(
                                                  decoration: InputDecoration(
                                                    // hintText: "Search farm...",
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4,
                                                            vertical: 4),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                  ),
                                                  style: TextStyle(
                                                      fontSize: Util
                                                          .scaleWidthFromDesign(
                                                              context, 8)),
                                                ),
                                                fit: FlexFit.loose,
                                                // constraints: BoxConstraints(maxHeight: 100),
                                              ),
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  fillColor: Colors.white,
                                                  labelText: "Select Farm",
                                                  // hintText: "Choose a farm",
                                                  labelStyle: TextStyle(
                                                      fontSize: Util
                                                          .scaleWidthFromDesign(
                                                              context, 8)),
                                                  filled: true,
                                                  // fillColor: Colors.grey.shade100,
                                                  // contentPadding: EdgeInsets.symmetric(
                                                  //     horizontal: 4, vertical: 4),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                              ),
                                              dropdownBuilder:
                                                  (context, selectedItem) =>
                                                      Text(
                                                selectedItem ?? "",
                                                style: TextStyle(
                                                    fontSize: Util
                                                        .scaleWidthFromDesign(
                                                            context,
                                                            8)), // 👈 selected item font
                                              ),
                                              itemAsString: (item) => item,
                                              onChanged: (value) =>
                                                  print("You selected $value"),
                                            ),
                                          ),

                                          //swith drop down
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        )),
                    Container(
                        width: Util.scaleWidthFromDesign(context, 30),
                        margin: EdgeInsets.only(
                            top: Util.scaleWidthFromDesign(context, 35)),

                        // color: Colors.green,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "3",
                                style: TextStyle(
                                    fontFamily: AppConstants.defaultFont,
                                    fontSize:
                                        Util.scaleWidthFromDesign(context, 13),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Farms",
                                style: TextStyle(
                                    fontFamily: AppConstants.defaultFont,
                                    fontSize:
                                        Util.scaleWidthFromDesign(context, 7),
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: Util.scaleWidthFromDesign(context, 40),
                        margin: EdgeInsets.only(
                            top: Util.scaleWidthFromDesign(context, 35)),

                        // color: Colors.green,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "345",
                                style: TextStyle(
                                    fontFamily: AppConstants.defaultFont,
                                    fontSize:
                                        Util.scaleWidthFromDesign(context, 13),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Coops",
                                style: TextStyle(
                                    fontFamily: AppConstants.defaultFont,
                                    fontSize:
                                        Util.scaleWidthFromDesign(context, 7),
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: Util.scaleWidthFromDesign(context, 35)),
                        width: Util.scaleWidthFromDesign(context, 40),
                        // color: Colors.green,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "2.3M",
                                style: TextStyle(
                                    fontFamily: AppConstants.defaultFont,
                                    fontSize:
                                        Util.scaleWidthFromDesign(context, 13),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Flock",
                                style: TextStyle(
                                    fontFamily: AppConstants.defaultFont,
                                    fontSize:
                                        Util.scaleWidthFromDesign(context, 7),
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          top: Util.scaleWidthFromDesign(context, 0)),
                      width: Util.scaleWidthFromDesign(context, 15),
                      // color: Colors.green,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.penToSquare,
                            size: Util.scaleWidthFromDesign(context, 15),
                          )),
                    ),
                  ],
                )),
          ],
        ));
  }
}
