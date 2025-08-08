import 'package:Cooply/models/dtos/loginResponse.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/AppConstants.dart';
import '../utils/util.dart';

class FarmCard extends StatefulWidget {
  final LoginResponse? loginResponse;

  FarmCard({super.key, required this.loginResponse});

  @override
  State<StatefulWidget> createState() => _FarmCardState();
}

class _FarmCardState extends State<FarmCard> {
  final List<String> dropDownItems = ['Apple', 'Banana', 'Mango', 'Orange'];

  late LoginResponse loginResponse;

  final TextEditingController _farmTextController = TextEditingController();
  final TextEditingController _farmLocationController = TextEditingController();
  final TextEditingController _farmDetailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginResponse = widget.loginResponse!;
  }

  //todo: handle the service layer, get data, fetch farms,
  //todo: if there are no farms, show create farm.

  @override
  Widget build(BuildContext context) => farmCard(context);

  bool existingFarms = false;

  Container farmCard(BuildContext context) {
    return Container(
        height: Util.scaleWidthFromDesign(context, 100),
        width: Util.scaleWidthFromDesign(context, 320),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.black38, width: 1.0, style: BorderStyle.solid)),
        ),
        child: getExistingFarms(context));
  }

  Column getExistingFarms(BuildContext context) {
    if (existingFarms == true)
      return Column(
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
                                              searchFieldProps: TextFieldProps(
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
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                            dropdownBuilder:
                                                (context, selectedItem) => Text(
                                              selectedItem ?? "",
                                              style: TextStyle(
                                                  fontSize:
                                                      Util.scaleWidthFromDesign(
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
      );
    else {
      return Column(children: [
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Farms",
                  style: TextStyle(
                      fontFamily: AppConstants.defaultFont,
                      fontSize: Util.scaleWidthFromDesign(context, 13),
                      fontWeight: FontWeight.bold),
                ),


                //todo: create new farm button

              ),

              SizedBox(
                height: 25,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child:
                    SizedBox(
                      width: 200,
                    
                    child:

                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xFFB4C78C)),
                    foregroundColor: WidgetStateProperty.all(Color(0xFFFFFFFF)),

                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Border radius here
                      ),
                      // Custom color
                  ),
                  ),

                  onPressed: () {
                    showCreateFarmBottomSheet(context);

                  },
                  child: const Text("CREATE FARM"),
                ),
              ),
              ),


            ],
          ),
        ),
      ]);
    }
  }


  void showCreateFarmBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // allow full height control
      backgroundColor: Colors.transparent, // to allow rounded corners or shadows
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8, // 80% of screen height
          child: Container(
            // margin: const EdgeInsets.only(bottom: 80),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all( Radius.circular(10)),

            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24, // handle keyboard + spacing
              ),
              child: ListView(
                children: [
                  const Text(
                    "Create Farm",
                    style: TextStyle(fontFamily: AppConstants.defaultFont, fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _farmTextController,
                    decoration: InputDecoration(
                      labelText: ' Farm Name',
                      border: const OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter farm name';
                      }
                      return null;
                    },


                  ),
                   const SizedBox(height: 12),


                  TextFormField(
                    controller: _farmLocationController,
                    decoration: InputDecoration(
                      labelText: ' Farm Location',
                      border: const OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' enter farm location  ';
                      }
                      return null;
                    },


                  ),


                  const SizedBox(height: 12),
                  TextField(
                    controller: _farmDetailsController,
                    decoration: const InputDecoration(labelText: "Description",
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => {
                      //todo: work on the works
                      Navigator.pop(context)
                    },
                    child: const Text("SAVE",  style: TextStyle(fontSize: 16, fontFamily:AppConstants.defaultFont,color: Color(0XFFFFFFFF)),),
                  ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
