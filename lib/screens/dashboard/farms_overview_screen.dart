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

import '../../cards/map_card.dart';
import '../../models/dtos/address.dart';
import '../../models/dtos/farm.dart';
import '../../services/farm_service.dart';
import '../../utils/util.dart';

class FarmOverviewScreen extends StatefulWidget {
  final LoginResponse? loginResponse;

  FarmOverviewScreen({super.key, required this.loginResponse});

  @override
  State<StatefulWidget> createState() => _FarmOverviewState();
}

class _FarmOverviewState extends State<FarmOverviewScreen> {
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
          // Your action here
        },
        icon: Icon(Icons.add),
        label: Text("Add"),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => FarmOverviewScreen(
                              loginResponse: loginResponse,
                            )),
                  );
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
                        " ${getPrimaryAddress(defaultFarm).city},${getPrimaryAddress(defaultFarm).street},${getPrimaryAddress(defaultFarm).state}, ",
                    child: Text(
                      " : ${getPrimaryAddress(defaultFarm).city},${getPrimaryAddress(defaultFarm).street},${getPrimaryAddress(defaultFarm).state}, ",
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
              location: LatLng(getPrimaryAddress(defaultFarm).latitude,
                  getPrimaryAddress(defaultFarm).longitude),
            ),
          )
          // MapCard placeholder
        ],
      ),
    );
  }

  Address getPrimaryAddress(Farm farm) {
    final primaryAddress = farm.addresses.firstWhere(
      (a) => a.addressLevel?.toUpperCase() == 'PRIMARY', //todo: primary address
      orElse: () => Address(
        latitude: 0.0,
        longitude: 0.0,
        addressLevel: 'PRIMARY',
        street: ' na ',
        city: ' na ',
        state: ' na ',
        zipCode: ' na ',
        details: ' na ',
      ),
    );

    // return LatLng(primaryAddress.latitude, primaryAddress.longitude);
    return primaryAddress;
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
                      size: Util.scaleWidthFromDesign(context, 15),
                    ),
                    SizedBox(width: Util.scaleWidthFromDesign(context, 10)),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FarmOverviewScreen(
                                    loginResponse: loginResponse,
                                  )),
                        );
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
                          " ${getPrimaryAddress(farms[index]).city},${getPrimaryAddress(farms[index]).street},${getPrimaryAddress(farms[index]).state}, ",
                          child: Text(
                            " : ${getPrimaryAddress(farms[index]).city},${getPrimaryAddress(farms[index]).street},${getPrimaryAddress(farms[index]).state}, ",
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
