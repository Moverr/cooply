import 'dart:convert';

import 'package:Cooply/models/dtos/accountResponse.dart';
import 'package:Cooply/models/dtos/loginResponse.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:Cooply/widgets/farmListTyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cards/farm_location_input.dart';
import '../../cards/map_card.dart';
import '../../models/dtos/address.dart';
import '../../models/dtos/farm.dart';
import '../../models/dtos/requests/farm_request.dart';
import '../../services/farm_service.dart';
import '../../services/service_result.dart';
import '../../utils/util.dart';
import '../../widgets/overlays.dart';
import  '../../utils/util.dart';

class FarmOverviewScreen extends StatefulWidget {
  final LoginResponse? loginResponse;

  FarmOverviewScreen({super.key, required this.loginResponse});

  @override
  State<StatefulWidget> createState() => _FarmOverviewState();
}

class _FarmOverviewState extends State<FarmOverviewScreen> {

  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmLocationController = TextEditingController();
  final TextEditingController _farmDetailsController = TextEditingController();


  late Address address;

  late LoginResponse loginResponse;

  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> _filteredData = [];

  late FarmDataSource _farmDataSource;
  final FarmService _farmService = FarmService();

  // Coordinates for Musima, Jinja, Uganda (approx)
  final LatLng _location = LatLng(0.4564, 33.1892);

  //todo: getting the farm data
  Farm defaultFarm =
      new Farm(id: 01, name: "N/A", isDefault: true, details: '');
  late List<Farm> farms = [];
  bool existingFarms = false;
  bool loading = false;
  FarmService fmService = FarmService();

  @override
  void initState() {
    super.initState();
    loginResponse = widget.loginResponse!;
    // _farmDataSource = FarmDataSource(context);
    // _farmDataSource.fetchPage(0);
    fetchFarms();
  }

  Future<void> fetchFarms() async {
    setState(() {
      loading = true;
    });

    PaginatedFarmsResponse? farmsResponse = await fmService.getFarms(
        accountId: loginResponse?.defaultAccount.id,
        offset: 0,
        limit: 20,
        loginResponse: loginResponse); // your async fetch method

    setState(() {
      loading = false;
      if (farmsResponse!.content.isNotEmpty) {
        existingFarms = true;
        farms = farmsResponse.content;

        // defaultFarm = farms.first;

        if (farms.isNotEmpty) {
          farms.forEach((x) {
            if (x.isDefault == true) {
              defaultFarm = x;
            }
          });
        } else {
          defaultFarm =
              new Farm(id: 01, name: "N/A", isDefault: true, details: '');
        }
      }
      // true if farms fetched, else false
    });
  }

  // FarmDataSource initFarmDatasource = (context,loginResponse) => FarmDataSource(context, loginResponse) ;

  FarmDataSource Function(BuildContext, LoginResponse) initFarmDataSource =
      (context, loginResponse) => FarmDataSource(context);

  // Separate async method for initialization
  Future<void> _initializeData() async {
    await loadUser(); // Wait for loginResponse to be ready
/*
    _farmDataSource = initFarmDataSource(context, getLoginResponse());
    _farmDataSource.fetchPage(0);
    */
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter data based on search query
  void _filterData() {
    /*  final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = _dataSource.getData().where((row) {
        return row['name']!.toLowerCase().contains(query) ||
            row['account']!.toLowerCase().contains(query) ||
            row['status']!.toLowerCase().contains(query);
      }).toList();
    });

    */
  }

  Future<LoginResponse?> loadUser() async {
    final user = await getLoginResponse();
    if (user != null) {
      return user;
      // _farmDataSource = FarmDataSource(this.context,user);
    } else {
      return null;
    }
  }

  Future<LoginResponse?> getLoginResponse() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('login_response');

      if (jsonString == null || jsonString.isEmpty) {
        debugPrint('⚠️ No login_response found.');
        return null;
      }

      final Map<String, dynamic> json = jsonDecode(jsonString);
      final loginResponse = LoginResponse.fromJson(json);

      debugPrint('✅ Loaded LoginResponse: $json');
      return loginResponse;
    } catch (e, stack) {
      debugPrint('❌ Failed to load LoginResponse: $e\n$stack');
      return null;
    }
  }

  bool _isLoading = true;

  bool x = false;

  @override
  Widget build(BuildContext context) {
    _initializeData();

    return Scaffold(
      body: getFarmsWidget(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showCreateFarmBottomSheet(context);
          },
          backgroundColor: Colors.white70,
          icon: Icon(
            FontAwesomeIcons.buildingColumns,
            size: Util.scaleWidthFromDesign(context, 15),
          ),
          label: Text("Create Farm "),
        ),
    );
  }

  Widget getFarmsWidget(BuildContext context) {
    if (loading == true) {
      return Container(
        color: Colors.white,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
                title: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "Farms",
                      style: TextStyle(
                          fontSize: Util.scaleWidthFromDesign(context, 20),
                          fontFamily: AppConstants.defaultFont),
                    ),
                  ],
                ),
                children: [
                  //todo: work on the default Div
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ]),
            Expanded(child: getGhostLook()),
            SizedBox(
              height: 2,
            ),
            Expanded(child: getGhostLook()),
            SizedBox(
              height: 2,
            ),
            Expanded(child: getGhostLook()),
            SizedBox(
              height: 2,
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
                title: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                          Icons.arrow_back,
                        size: Util.scaleWidthFromDesign(context, 10),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "Farms",
                      style: TextStyle(
                          fontSize: Util.scaleWidthFromDesign(context, 20),
                          fontFamily: AppConstants.defaultFont),
                    ),
                  ],
                ),
                children: [
                  //todo: work on the default Div
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ]),
            Expanded(child: getDefaultFarm(context)),
            SizedBox(
              height: 10,
            ),
            Expanded(child: otherFarms(context)),
          ],
        ),
      );
    }
  }

  Padding getGhostLook() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 20,
              width: 150,
              color: Colors.grey.shade300), // fake title
          const SizedBox(height: 8),
          Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey.shade300), // fake content
        ],
      ),
    );
  }

  Widget getDefaultFarm(BuildContext context) {
    return Container(
      height: Util.scaleWidthFromDesign(context, 100),
      margin: EdgeInsets.symmetric(
        vertical: Util.scaleWidthFromDesign(context, 8),
        horizontal: Util.scaleWidthFromDesign(context, 16),
      ),
      padding: EdgeInsets.all(Util.scaleWidthFromDesign(context, 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            height: Util.scaleWidthFromDesign(context, 30),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0XFFE4D8B6),
                  width: 1.0,
                ),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Current Farm",
              style: TextStyle(
                fontFamily: AppConstants.defaultFont,
                fontWeight: FontWeight.w700,
                fontSize: Util.scaleWidthFromDesign(context, 13),
              ),
            ),
          ),
          SizedBox(height: Util.scaleWidthFromDesign(context, 2)),

          // Farm row (icon + name + edit button)
          Row(
            children: [
              Icon(
                FontAwesomeIcons.buildingColumns,
                size: Util.scaleWidthFromDesign(context, 15),
              ),
              SizedBox(width: Util.scaleWidthFromDesign(context, 10)),
              Expanded(
                child: Text(
                  defaultFarm.name,
                  style: TextStyle(
                    fontFamily: AppConstants.defaultFont,
                    fontWeight: FontWeight.bold,
                    fontSize: Util.scaleWidthFromDesign(context, 10),
                    color: Color(0XFFCE4B4B),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                   //todo: implement Edit
                },
                icon: Icon(
                  FontAwesomeIcons.penToSquare,
                  size: Util.scaleWidthFromDesign(context, 10),
                ),
              ),
            ],
          ),
          SizedBox(height: Util.scaleWidthFromDesign(context, 2)),

          // Status / Coops / Location row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: Util.scaleWidthFromDesign(context, 25)),
              Text(
                "Status",
                style: TextStyle(
                  fontFamily: AppConstants.defaultFont,
                  fontWeight: FontWeight.bold,
                  fontSize: Util.scaleWidthFromDesign(context, 9),
                  color: Color(0XFF000000),
                ),
              ),
              Text(
                " : ${defaultFarm.status}",
                style: TextStyle(
                  fontFamily: AppConstants.defaultFont,
                  fontWeight: FontWeight.normal,
                  fontSize: Util.scaleWidthFromDesign(context, 9),
                  color: Color(0XFF000000),
                ),
              ),
              SizedBox(width: Util.scaleWidthFromDesign(context, 25)),
              Text(
                "Coops",
                style: TextStyle(
                  fontFamily: AppConstants.defaultFont,
                  fontWeight: FontWeight.bold,
                  fontSize: Util.scaleWidthFromDesign(context, 9),
                  color: Color(0XFF000000),
                ),
              ),
              Text(
                " : N/A",
                style: TextStyle(
                  fontFamily: AppConstants.defaultFont,
                  fontWeight: FontWeight.normal,
                  fontSize: Util.scaleWidthFromDesign(context, 9),
                  color: Color(0XFF000000),
                ),
              ),
              SizedBox(width: Util.scaleWidthFromDesign(context, 25)),
              Text(
                "Location",
                style: TextStyle(
                  fontFamily: AppConstants.defaultFont,
                  fontWeight: FontWeight.bold,
                  fontSize: Util.scaleWidthFromDesign(context, 9),
                  color: Color(0XFF000000),
                ),
              ),
              SizedBox(
                  width: Util.scaleWidthFromDesign(context, 70),
                  child: Tooltip(
                    message:
                        " ${Util.getPrimaryAddress(defaultFarm).city},${Util.getPrimaryAddress(defaultFarm).street},${Util.getPrimaryAddress(defaultFarm).state}, ",
                    child: Text(
                      " : ${Util.getPrimaryAddress(defaultFarm).city},${Util.getPrimaryAddress(defaultFarm).street},${Util.getPrimaryAddress(defaultFarm).state}, ",
                      style: TextStyle(
                        fontFamily: AppConstants.defaultFont,
                        fontWeight: FontWeight.normal,
                        fontSize: Util.scaleWidthFromDesign(context, 9),
                        color: Color(0XFF000000),
                      ),

                      maxLines: 1, // restrict to single line
                      overflow:
                          TextOverflow.ellipsis, // hide overflow with "..."
                    ),
                  )),
            ],
          ),
          SizedBox(height: Util.scaleWidthFromDesign(context, 2)),

          Expanded(
            child: MapCard(
              location: LatLng(Util.getPrimaryAddress(defaultFarm).latitude,
                  Util.getPrimaryAddress(defaultFarm).longitude),
            ),
          )
          // MapCard placeholder
        ],
      ),
    );
  }



  Widget otherFarms(BuildContext context) {
    return Container(
      height: Util.scaleWidthFromDesign(context, 100),
      margin: EdgeInsets.symmetric(
        vertical: Util.scaleWidthFromDesign(context, 8),
        horizontal: Util.scaleWidthFromDesign(context, 16),
      ),
      padding: EdgeInsets.all(Util.scaleWidthFromDesign(context, 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            height: Util.scaleWidthFromDesign(context, 30),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0XFFE4D8B6),
                  width: 1.0,
                ),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Other Farms",
              style: TextStyle(
                fontFamily: AppConstants.defaultFont,
                fontWeight: FontWeight.w700,
                fontSize: Util.scaleWidthFromDesign(context, 12),
              ),
            ),
          ),

          SizedBox(height: Util.scaleWidthFromDesign(context, 2)),

          Expanded(
              child: ListView.builder(
            itemCount: farms.length,
            itemBuilder: (context, index) {
              return Wrap(children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.buildingColumns,
                      size: Util.scaleWidthFromDesign(context, 9),
                    ),
                    SizedBox(width: Util.scaleWidthFromDesign(context, 5)),
                    Text(
                      farms[index].name,
                      style: TextStyle(
                        fontFamily: AppConstants.defaultFont,
                        fontWeight: FontWeight.bold,
                        fontSize: Util.scaleWidthFromDesign(context, 10),
                        color: Color(0XFFCE4B4B),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        //todo: not yet implemented
                      },
                      icon: Icon(
                        FontAwesomeIcons.penToSquare,
                        size: Util.scaleWidthFromDesign(context, 10),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Util.scaleWidthFromDesign(context, 2)),

                // Status / Coops / Location row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: Util.scaleWidthFromDesign(context, 15)),
                    Text(
                      "Status",
                      style: TextStyle(
                        fontFamily: AppConstants.defaultFont,
                        fontWeight: FontWeight.bold,
                        fontSize: Util.scaleWidthFromDesign(context, 9),
                        color: Color(0XFF000000),
                      ),
                    ),
                    Text(
                      " : ${farms[index].status}",
                      style: TextStyle(
                        fontFamily: AppConstants.defaultFont,
                        fontWeight: FontWeight.normal,
                        fontSize: Util.scaleWidthFromDesign(context, 9),
                        color: Color(0XFF000000),
                      ),
                    ),
                    SizedBox(width: Util.scaleWidthFromDesign(context, 25)),
                    Text(
                      "Coops",
                      style: TextStyle(
                        fontFamily: AppConstants.defaultFont,
                        fontWeight: FontWeight.bold,
                        fontSize: Util.scaleWidthFromDesign(context, 9),
                        color: Color(0XFF000000),
                      ),
                    ),
                    Text(
                      " : N/A",
                      style: TextStyle(
                        fontFamily: AppConstants.defaultFont,
                        fontWeight: FontWeight.normal,
                        fontSize: Util.scaleWidthFromDesign(context, 9),
                        color: Color(0XFF000000),
                      ),
                    ),
                    SizedBox(width: Util.scaleWidthFromDesign(context, 25)),
                    Text(
                      "Location",
                      style: TextStyle(
                        fontFamily: AppConstants.defaultFont,
                        fontWeight: FontWeight.bold,
                        fontSize: Util.scaleWidthFromDesign(context, 9),
                        color: Color(0XFF000000),
                      ),
                    ),

                    SizedBox(
                        width: Util.scaleWidthFromDesign(context, 70),
                        child: Tooltip(
                          message:
                          " ${Util.getPrimaryAddress(farms[index]).city},${Util.getPrimaryAddress(farms[index]).street},${Util.getPrimaryAddress(farms[index]).state}, ",
                          child: Text(
                            " : ${Util.getPrimaryAddress(farms[index]).city},${Util.getPrimaryAddress(farms[index]).street},${Util.getPrimaryAddress(farms[index]).state}, ",
                            style: TextStyle(
                              fontFamily: AppConstants.defaultFont,
                              fontWeight: FontWeight.normal,
                              fontSize: Util.scaleWidthFromDesign(context, 9),
                              color: Color(0XFF000000),
                            ),

                            maxLines: 1, // restrict to single line
                            overflow:
                            TextOverflow.ellipsis, // hide overflow with "..."
                          ),
                        )),


                  ],
                ),
                SizedBox(height: Util.scaleWidthFromDesign(context, 20)),
              ]);
            },
          )),

          // MapCard placeholder
        ],
      ),
    );
  }


  void showCreateFarmBottomSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                      "Create Farm",
                      style: TextStyle(
                        fontFamily: AppConstants.defaultFont,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Farm Name
                    TextFormField(
                      controller: _farmNameController,
                      decoration: InputDecoration(
                        labelText: 'Farm Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Farm name is required';
                        }
                        if (value.length < 3) {
                          return 'Farm name must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Farm Location
                    FarmLocationInput(
                      controller: _farmLocationController,
                      onLocationSelected: (selectedAddress) {
                        address = selectedAddress;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Description
                    TextFormField(
                      controller: _farmDetailsController,
                      decoration: InputDecoration(
                        labelText: "Description",
                        hintText: "Add a few details about your farm...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 30),

                    // SAVE button
                    SizedBox(
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

                          FarmRequest fr = FarmRequest(
                            accountId: loginResponse.defaultAccount.id,
                            name: _farmNameController.text.trim(),
                            addresses: [address],
                          );

                          // Show loading
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) =>
                            const Center(child: CircularProgressIndicator()),
                          );

                          try {
                            ServiceResult result = await fmService.createFarm(
                              farm: fr,
                              loginResponse: loginResponse,
                              accountId: loginResponse.defaultAccount.id,
                            );

                            Navigator.of(context).pop(); // remove loader

                            if (result.success) {
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
                              fetchFarms();
                            } else {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierColor: Colors.black.withOpacity(0.5),
                                builder: (context) => CustomOverlay(
                                  message: result.errorMessage ??
                                      "Failed to create a farm",
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}

class FarmDataSource extends DataTableSource {
  final BuildContext context;

  List<Farm> farms = [];
  int totalRows = 0;
  int rowsPerPage = 2;
  int page = 0;

  FarmDataSource(this.context);

  Future<LoginResponse?> getLoginResponse() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('login_response');

      if (jsonString == null || jsonString.isEmpty) {
        debugPrint('⚠️ No login_response found.');
        return null;
      }

      final Map<String, dynamic> json = jsonDecode(jsonString);
      final loginResponse = LoginResponse.fromJson(json);

      debugPrint('✅ Loaded LoginResponse: $loginResponse');
      return loginResponse;
    } catch (e, stack) {
      debugPrint('❌ Failed to load LoginResponse: $e\n$stack');
      return null;
    }
  }

  Future<void> fetchPage(int pageIndex) async {
    LoginResponse? loginResponse = await getLoginResponse();

    FarmService farmService = FarmService();

    final offset = pageIndex * rowsPerPage;
    try {
      final response = await farmService.getFarms(
          accountId: 16,
          offset: offset,
          limit: rowsPerPage,
          loginResponse: loginResponse);

      farms = response!.content;
      totalRows = response.totalElements;
      page = response.pageNumber;
      debugPrint("Reached this Part :-------");
      notifyListeners();
    } catch (e) {
      farms = [];
      totalRows = 0;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching farms: $e")),
      );
    }
  }

  final List<Map<String, String>> _data = List.empty();

  @override
  DataRow? getRow(int index) {
    if (index >= farms.length) return null;
    final farm = farms[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(farm.name.toString())),
      DataCell(Text(farm.status.toString())),
      DataCell(Text(farm.modifiedOn.toString())),
      getActionCell(farm.id)
    ]);
  }

  DataCell getActionCell(int index) {
    return DataCell(Row(
      children: [
        // Edit Button
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            print('Edit clicked for row $index');
            // Handle Edit action
          },
        ),
        // Delete Button
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            print('Delete clicked for row $index');
            // Handle Delete action
          },
        ),
        // View Button
        IconButton(
          icon: const Icon(Icons.visibility, color: Colors.green),
          onPressed: () {
            print('View clicked for row $index');
            // Handle View action
          },
        ),
      ],
    ));
  }

  /*
  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final row = _data[index];
    return DataRow(cells: [
      // DataCell(Text(row['account']!)),
      DataCell(Text(row['name']!)),
      DataCell(Text(row['status']!)),
      // DataCell(Text(row['author']!)),
      DataCell(Text(row['dateCreated']!)),
      DataCell(
        Row(
          children: [
            // Edit Button
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                print('Edit clicked for row $index');
                // Handle Edit action
              },
            ),
            // Delete Button
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                print('Delete clicked for row $index');
                // Handle Delete action
              },
            ),
            // View Button
            IconButton(
              icon: const Icon(Icons.visibility, color: Colors.green),
              onPressed: () {
                print('View clicked for row $index');
                // Handle View action
              },
            ),
          ],
        )
      ),
    ]);
  }
  */

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalRows;

  @override
  int get selectedRowCount => 0;

  List<Map<String, String>> getData() => _data;
}
