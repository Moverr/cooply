import 'package:Cooply/models/dtos/address.dart';
import 'package:Cooply/models/dtos/loginResponse.dart';
import 'package:Cooply/models/dtos/requests/farm_request.dart';
import 'package:Cooply/services/farm_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/dtos/farm.dart';
import '../services/service_result.dart';
import '../utils/AppConstants.dart';
import '../utils/util.dart';
import '../widgets/overlays.dart';
import 'farm_location_input.dart';

class FarmCard extends StatefulWidget {
  final LoginResponse? loginResponse;

  FarmCard({super.key, required this.loginResponse});

  @override
  State<StatefulWidget> createState() => _FarmCardState();
}


class _FarmCardState extends State<FarmCard> {
  final List<String> dropDownItems = ['Apple', 'Banana', 'Mango', 'Orange'];

  late LoginResponse loginResponse;

  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmLocationController = TextEditingController();
  final TextEditingController _farmDetailsController = TextEditingController();

  late Address address;

  FarmService fmService = FarmService();

  List<Farm> farms = [];

  @override
  void initState() {
    super.initState();
    loginResponse = widget.loginResponse!;
    fetchFarms();

  }

  Future<void> fetchFarms() async {
    setState(() {
      loading = true;
    });

    PaginatedFarmsResponse? farmsResponse = await fmService.getFarms(accountId: loginResponse.defaultAccount.id,offset: 0,limit: 20,loginResponse: loginResponse); // your async fetch method

    setState(() {
   if(farmsResponse!.content.isNotEmpty) {
     loading = false;
     existingFarms = true;
     farms = farmsResponse.content;
   }
   // true if farms fetched, else false
    });
  }




  bool existingFarms = false;
  bool loading = false;
 
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
        child: loadFarms(context));
  }

  Column loadFarms(BuildContext context) {
    if(loading ==true){

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
                child: Text("Loading ....")
              ),
            ],
          ),
        ),
      ]);
      
      
      
    }
    if (existingFarms == true){
    return  displayFarms(context);
    }
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
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFFB4C78C)),
                      foregroundColor:
                          WidgetStateProperty.all(Color(0xFFFFFFFF)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Border radius here
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

  Column displayFarms(BuildContext context) {
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
                                        farms[0].name,
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
                                      padding: EdgeInsets.only(top: 10), //padding top
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
  }

  void showCreateFarmBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // allow full height control
      backgroundColor: Colors.transparent,
      // to allow rounded corners or shadows
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8, // 80% of screen height
          child: Container(
            // margin: const EdgeInsets.only(bottom: 80),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    24, // handle keyboard + spacing
              ),
              child: ListView(
                children: [
                  const Text(
                    "Create Farm",
                    style: TextStyle(
                        fontFamily: AppConstants.defaultFont,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _farmNameController,
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

                  // Farm Location autocomplete field
                  FarmLocationInput(
                    controller: _farmLocationController,
                    onLocationSelected: (selectedAddress) {
                      address = selectedAddress;
                      // new Address(addressLevel: "location", street: street, city: city, state: state, zipCode: zipCode, latitude: latitude, longitude: longitude)
                    },
                  ),

                  const SizedBox(height: 12),
                  TextField(
                    controller: _farmDetailsController,
                    decoration: const InputDecoration(
                      labelText: "Description",
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
                      onPressed: () async {

                        FarmRequest fr = FarmRequest(
                          accountId: loginResponse.defaultAccount.id,
                          name: _farmNameController.text,
                          addresses: [address], // your Address instance
                        );

                        // Show loading dialog
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const Center(child: CircularProgressIndicator()),
                        );


                        // FarmService fmService = new FarmService();
                        // fmService.createFarm(farm: fr, loginResponse: loginResponse, accountId: loginResponse.defaultAccount.id);




                        try {

                          ServiceResult result = await fmService.createFarm(
                            farm: fr,
                            loginResponse: loginResponse,
                            accountId: loginResponse.defaultAccount.id,
                          );

                          // Remove loader
                          Navigator.of(context).pop();

                          if (result.success) {
                            // Close the form screen and pass result
                            Navigator.pop(context, fr);



                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierColor: Colors.black.withOpacity(0.5),
                              builder: (context) => const CustomOverlay(
                                message: "Farm saved successfully",
                                isSuccess: true,
                              ),
                            );


                          } else {

                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierColor: Colors.black.withOpacity(0.5),
                              builder: (context) => CustomOverlay(
                                message: result.errorMessage ??  "Failed to create a farm",
                                isSuccess: false,
                              ),
                            );


                          }
                        } catch (e) {
                          Navigator.of(context).pop(); // remove loader
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('An error occurred: $e')),
                          );
                        }

                        // Navigator.pop(context, fr);
                      },
                      child: const Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppConstants.defaultFont,
                            color: Color(0XFFFFFFFF)),
                      ),
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
