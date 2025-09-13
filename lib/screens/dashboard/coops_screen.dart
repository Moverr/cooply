import 'package:Cooply/models/dtos/coop_response.dart';
import 'package:Cooply/models/dtos/loginResponse.dart';
import 'package:Cooply/models/dtos/requests/coop_request.dart';
import 'package:Cooply/services/coop_service.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../cards/address_location_input.dart';
import '../../models/dtos/address.dart';
import '../../models/dtos/farm.dart';
import '../../models/dtos/requests/farm_request.dart';
import '../../services/farm_service.dart';
import '../../services/service_result.dart';
import '../../utils/coop_calculator.dart';
import '../../utils/util.dart';
import '../../widgets/coopListTyle.dart';
import '../../widgets/overlays.dart';

class CoopsScreen extends StatefulWidget {
  final LoginResponse? loginResponse;

  const CoopsScreen({super.key, required this.loginResponse});

  @override
  State<StatefulWidget> createState() => _CoopState();
}

class _CoopState extends State<CoopsScreen> {
  // Define state map for power options
  Map<String, bool> _powerOptions = {
    "NATIONAL": false,
    "SOLAR": false,
    "BATTERY": false,
    "OTHER": false,
  };

  // Define state map for water options
  final Map<String, bool> _waterOptions = {
    "NATIONAL": false,
    "BORE": false,
    "UNDERGROUND": false,
    "OTHER": false,
  };

  // Power checkboxes
  bool _powerGrid = false;
  bool _powerSolar = false;

  // Water checkboxes
  bool _waterGrid = false;
  bool _waterUnderground = false;

  late Address address;

  final TextEditingController _coopNameController = TextEditingController();
  final TextEditingController _coopGroundAreaController =
      TextEditingController();
  final TextEditingController _coopCapacityController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _farmDetailsController = TextEditingController();

  TextEditingController _searchController = TextEditingController();
  String? selectedType = "DEEP_LITTER";

  List<Map<String, String>> _filteredData = [];

  bool _isSearching = false;

  //todo: getting the farm data
  Farm defaultFarm =
      new Farm(id: 01, name: "N/A", isDefault: true, details: '');
  bool existingFarms = false;
  bool loading = false;
  FarmService fmService = FarmService();
  CoopService cpService = CoopService();

  int offset = 0;
  int limit = 3;

  late List<Farm> farms = [];
  late List<CoopResponse> coops = [];

  late LoginResponse loginResponse;

  @override
  void initState() {
    super.initState();
    loginResponse = widget.loginResponse!;

    getDefaultFarm();
  }

  void handleGroundArea() {
    setState(() {
      // Parse the ground area safely
      double groundArea =
          double.tryParse(_coopGroundAreaController.text) ?? 0.0;

      // Calculate capacity
      double capacity = CoopCalculator.calculateCapacityByType(
          groundArea, selectedType! ?? "");

      // Update the capacity controller
      _coopCapacityController.text = "$capacity";
    });
  }

  Future<void> getDefaultFarm() async {
    fetchFarms();
  }

  Future<void> fetchFarms() async {
    setState(() {
      loading = true;
    });

    // PaginatedFarmsResponse? farmsResponse = await

    fmService
        .getFarms(
            accountId: loginResponse.defaultAccount.id,
            offset: 0,
            limit: 20,
            loginResponse: loginResponse)
        .then((List<Farm>? farmsResponse) {
      setState(() {
        loading = false;
        if (farmsResponse!.isNotEmpty) {
          existingFarms = true;
          farms = farmsResponse;

          if (farms.isNotEmpty) {
            farms.forEach((farm) {
              if (farm.isDefault == true) {
                defaultFarm = farm;
                fetchCoops(farm);
              }
            });
          } else {
            defaultFarm =
                new Farm(id: 01, name: "N/A", isDefault: true, details: '');
          }
        }
        // true if farms fetched, else false
      });

      //todo: fetch the coop data.

      //set the data
    }); // your async fetch method
  }

  Future<void> fetchCoops(Farm farm) async {
    setState(() {
      this.coops = [];
    });

    cpService
        .getList(
      farmId: farm.id,
      offset: offset,
      limit: limit,
      loginResponse: loginResponse,
    )
        .then((List<CoopResponse> coopResponseList) {
      setState(() {
        if (coopResponseList.isNotEmpty) {
          this.coops = coopResponseList;

          this.offset = 0;
        }
      });

      //set the data
    }); // your async fetch method
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search coops...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black38),

                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  //   ),
                  prefixIcon: Icon(Icons.search),
                ),
                style: TextStyle(
                  color: Colors.black38,
                  fontFamily: AppConstants.defaultFont,
                  fontSize: 16,
                ),
                onChanged: (query) {
                  // You can filter your list here
                  print("Searching for: $query");
                },
              )
            : Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  " 🏠 Coop Management",
                  style: TextStyle(
                    fontFamily: AppConstants.defaultFont,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                  // Optionally reset list or results
                }
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            getHeaderWidget(context),
            Expanded(
                child: coops.length == 0
                    ? getGhostWidget(context)

                    : ListView.builder(
                        itemCount: coops.length,
                        itemBuilder: (context, index) {
                          return CoopListTyle(
                            coop: coops[index],
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Tapped ${coops[index].name}')),
                              );
                            },
                          );
                        },
                      )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showCreateCoopBottomSheet(context);
        },
        backgroundColor: Colors.white70,
        icon: Icon(
          FontAwesomeIcons.buildingColumns,
          size: Util.scaleWidthFromDesign(context, 15),
        ),
        label: Text("Create Coop "),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget getHeaderWidget(BuildContext context) {
    if (loading == true) {
      return SizedBox(
        height: 50,
        child: Container(
          padding: EdgeInsets.only(left: 10),
          color: Colors.green.shade100,
          alignment: Alignment.centerLeft,
          child: Text(
            "Loading ... ",
            style: TextStyle(
                fontFamily: AppConstants.defaultFont,
                fontSize: 12,
                fontWeight: FontWeight.w100),
          ),
        ),
      );
    } else {
      return Container(
          height: Util.scaleWidthFromDesign(context, 30),
          width: double.infinity,
          margin: EdgeInsets.symmetric(
              vertical: Util.scaleWidthFromDesign(context, 5), horizontal: 16),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0XFFE4D8B6),
                width: 1.0,
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.buildingColumns,
                size: Util.scaleWidthFromDesign(context, 12),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                defaultFarm.name,
                style: TextStyle(
                    fontFamily: AppConstants.defaultFont,
                    fontWeight: FontWeight.w700,
                    fontSize: Util.scaleWidthFromDesign(context, 14),
                    color: Color(0XFFCE4B4B)),
              ),
              Spacer(),
              Text(
                "Location :  ",
                style: TextStyle(
                  fontFamily: AppConstants.defaultFont,
                  fontWeight: FontWeight.w700,
                  fontSize: Util.scaleWidthFromDesign(context, 10),
                ),
              ),
              Text(
                " ${Util.getPrimaryAddress(defaultFarm).city} ${Util.getPrimaryAddress(defaultFarm).street} ${Util.getPrimaryAddress(defaultFarm).state} ",
                style: TextStyle(
                    fontFamily: AppConstants.defaultFont,
                    fontWeight: FontWeight.normal,
                    fontSize: Util.scaleWidthFromDesign(context, 10),
                    color: Color(0XFF0E76A3)),
              ),
            ],
          ));
    }
  }

  void showCreateCoopBottomSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
            heightFactor: 0.85,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                  border: Border(
                    top: BorderSide(
                      color: Color(0XFFB6ECBF), // border color
                      width: Util.scaleWidthFromDesign(
                          context, 15.0), // border thickness/height
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                  ),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 50,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const Text(
                          "Create Coop ",
                          style: TextStyle(
                            fontFamily: AppConstants.defaultFont,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),
                        Text("Name"),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _coopNameController,
                          decoration: InputDecoration(
                            labelText: 'Enter Coop Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            //Colors.grey[100],
                            prefixIcon: const Padding(
                              padding:
                                  EdgeInsets.all(12.0), // adjust for spacing
                              child: FaIcon(
                                FontAwesomeIcons.house, // choose your icon
                                size: 20,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Coop name is required';
                            }
                            if (value.length < 3) {
                              return 'Coop  name must be at least 3 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        Text("Type"),
                        const SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Select Coop Type',
                            border: OutlineInputBorder(),
                          ),
                          value: selectedType,
                          items: CoopCalculator.CoopType.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.value, // e.g. "DEEP_LITTER"
                              child: Text(entry.key), // e.g. "deepLitter"
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                              handleGroundArea();
                            });

                            if (value != null) {
                              final capacity =
                                  CoopCalculator.calculateCapacityByType(
                                      100, value);
                              debugPrint(
                                  "Capacity for $value = $capacity birds");
                            }
                          },
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            SizedBox(
                              width: 160,
                              //Util.scaleWidthFromDesign(context, 160),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _coopGroundAreaController,
                                onChanged: (value) {
                                  handleGroundArea();
                                },
                                decoration: InputDecoration(
                                  labelText: 'Ground Area [M Sqrd] ',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,

                                  //Colors.grey[100],
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(
                                        12.0), // adjust for spacing
                                    child: FaIcon(
                                      FontAwesomeIcons
                                          .squareFontAwesome, // choose your icon
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Field is required';
                                  }

                                  if (double.tryParse(value.trim()) == null) {
                                    return 'Enter  number';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 160,
                              //Util.scaleWidthFromDesign(context, 160),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _coopCapacityController,
                                decoration: InputDecoration(
                                  labelText: 'Bird Capacity',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  //Colors.grey[100],
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(
                                        12.0), // adjust for spacing
                                    child: FaIcon(
                                      FontAwesomeIcons
                                          .circleCheck, // choose your icon
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Bird Capacity Required';
                                  }

                                  return null;
                                },
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Power Section
                        ExpansionTile(
                          title: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.bolt, // Power icon
                                color: Colors.black,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Power",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          collapsedBackgroundColor: Colors.blueGrey[200],
                          backgroundColor: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          children: _powerOptions.keys.map((key) {
                            return CheckboxListTile(
                              title: Text(
                                key[0] +
                                    key
                                        .substring(1)
                                        .toLowerCase(), // pretty label
                              ),
                              value: _powerOptions[key],
                              onChanged: (val) {
                                setState(() {
                                  _powerOptions[key] = val ?? false;
                                });
                              },
                            );
                          }).toList(),
                        ),

                        SizedBox(
                          height: 20,
                        ),
// Water Section

                        // Define state map for water options

                        ExpansionTile(
                          title: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.droplet, // Water icon
                                color: Colors.black,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Water",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          collapsedBackgroundColor: Colors.lightBlue[200],
                          backgroundColor: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          children: _waterOptions.keys.map((key) {
                            return CheckboxListTile(
                              title: Text(
                                key[0] +
                                    key
                                        .substring(1)
                                        .toLowerCase(), // pretty label
                              ),
                              value: _waterOptions[key],
                              onChanged: (val) {
                                setState(() {
                                  _waterOptions[key] = val ?? false;
                                });
                              },
                            );
                          }).toList(),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black26,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "CANCEL",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppConstants.defaultFont,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 200,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[600],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () async {
                                  if (!formKey.currentState!.validate()) return;

                                  CoopRequest coopRequest = CoopRequest(
                                    farmId: defaultFarm.id,
                                    name: _coopNameController.text.trim(),
                                    area:_coopGroundAreaController.text,
                                    capacity: double.parse(_coopCapacityController.text),
                                    type: selectedType!,
                                    power: _powerOptions.entries
                                        .where((entry) => entry.value) // only selected
                                        .map((entry) => PowerRequest(
                                      name: entry.key,    // use the key as the name
                                      status: "PENDING",  // optional, default status
                                      // details: "",        // optional details
                                    ))
                                        .toList(),
                                    water: _waterOptions.entries
                                        .where((e) => e.value)
                                        .map((e) => WaterRequest(
                                      source: e.key,
                                      status: "PENDING",
                                    ))
                                        .toList(),


                                  );

                                  // Show loading
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => const Center(
                                        child: CircularProgressIndicator()),
                                  );

                                  try {
                                    ServiceResult result =
                                        await cpService.create(
                                      coopRequest: coopRequest,
                                      loginResponse: loginResponse,
                                      farmId:defaultFarm.id,
                                    );

                                    Navigator.of(context)
                                        .pop(); // remove loader

                                    if (result.success) {
                                      Navigator.pop(context, coopRequest);

                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        builder: (context) =>
                                            const CustomOverlay(
                                          message: "Coop saved successfully",
                                          isSuccess: true,
                                        ),
                                      );
                                      fetchFarms();
                                    } else {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        builder: (context) => CustomOverlay(
                                          message: result.errorMessage ??
                                              "Failed to create a coop",
                                          isSuccess: false,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    Navigator.of(context)
                                        .pop(); // remove loader
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('An error occurred: $e')),
                                    );
                                  }
                                },
                                child: const Text(
                                  "SAVE",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppConstants.defaultFont,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        // SAVE button
                      ],
                    ),
                  ),
                ),
              );
            }));
      },
    );
  }

  Widget getGhostWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar
          Container(
            width: 150,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          // Multiple lines
          Container(
            width: double.infinity,
            height: 12,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            height: 12,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 6),
          Container(
            width: 100,
            height: 12,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
