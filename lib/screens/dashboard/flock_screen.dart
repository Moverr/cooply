/*
 * Copyright (c) 2025. This is a product of Khoodilabs
 */

import 'dart:convert';

import 'package:Cooply/models/dtos/accountResponse.dart';
import 'package:Cooply/models/dtos/coop.dart';
import 'package:Cooply/models/dtos/flock.dart';
import 'package:Cooply/models/dtos/loginResponse.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:Cooply/widgets/farmListTyle.dart';
import 'package:Cooply/widgets/flockListTyle.dart';
import 'package:Cooply/widgets/ghost_loader_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/dtos/coop_response.dart';
import '../../models/dtos/farm.dart';
import '../../services/coop_service.dart';
import '../../services/farm_service.dart';
import '../../utils/util.dart';
import '../../widgets/coopListTyle.dart';
import '../../widgets/custom_expansion_tile.dart';

class FlockScreen extends StatefulWidget {
  final LoginResponse? loginResponse;
  const FlockScreen({super.key, required this.loginResponse});

  @override
  State<StatefulWidget> createState() => _FlockState();
}

class _FlockState extends State<FlockScreen> {
  ScrollController _scrollController = ScrollController();

  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> _filteredData = [];
  final FarmService fmService = FarmService();
  final GlobalKey expansionTileKey = GlobalKey();
  bool _isExpanded = true;
  bool _isSearching = false;
  bool _coopsLoaded = false;

  bool existingFarms = false;
  bool loading = false;
  CoopService cpService = CoopService();
  // CoopService cpService = CoopService();


  late List<Farm> farms = [];
  late List<CoopResponse> coops = [];
  late List<Flock> _flocks = [];

  CoopResponse? selectedCoop; // state variable

  int offset = 0;
  int limit = 10;

  late LoginResponse loginResponse;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    loginResponse = widget.loginResponse!;
    getDefaultFarm();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // safe to use scrollController here
        print('ScrollController attached. Offset: ${_scrollController.offset}');
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        double currentOffset = _scrollController.offset;

        if (currentOffset > 30) {
          if (_isScrollingUp == false && _isExpanded == true) {
            setState(() {
              // _isScrollingUp = true;
              // _isExpanded = false;
            });
          }
        } else {
          if (_isScrollingUp == true ) {
            setState(() {
              // _isScrollingUp = false;
              // _isExpanded = true;
            });
          }
        }

        print('Scrolling, offset: $currentOffset');
      }
    });


  }

  double _lastOffset = 0;
  bool _isScrollingUp = false;


  Future<void> getDefaultFarm() async {
    setState(() {
      loading = true;
    });

    fmService
        .getDefaultFarm(
            accountId: loginResponse.defaultAccount.id,
            loginResponse: loginResponse)
        .then((Farm? farmsResponse) {

      print(farmsResponse);
      setState(() {
        loading = false;
        if (farmsResponse != null) {
          defaultFarm = farmsResponse;
          fetchCoops(defaultFarm);
        }
        //??
        // new Farm(id: 01, name: "N/A", isDefault: true, details: '');
      });
    });
  }

  Future<void> fetchCoops(Farm farm) async {
    setState(() {
      this.coops = [];
      this._coopsLoaded == false;
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
          this._coopsLoaded = true;

          this.offset = 0;
        }
      });

      //set the data
    }); // your async fetch method
  }

  late bool loadingFlock = true;

  Future<void> fetchFlock(Farm farm) async {
    setState(() {
      this.coops = [];
      this.loadingFlock = true;
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
          this.loadingFlock = false;
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
    _scrollController.dispose();
    super.dispose();
  }





  final List<Flock> items = [
    Flock(
        id: 1,
        batchName: "1202202401",
        coopName: "Gianna House",
        author: "Muyinda ROgers",
        status: "Active",
        createdOn: "12-10-2024",
        modifiedOn: "12-10-2024",
        currentBirdCount: double.parse(34000.toString()),
        type: "Deep Litre",
        mortality: 120,
        acquiredOn: "12-10-2024",
        stage: "Pre Layer Stage", // Operation Stage,
        stock: 123000),
    Flock(
        id: 1,
        batchName: "1202202401",
        coopName: "Gianna House",
        author: "Muyinda ROgers",
        status: "Active",
        createdOn: "12-10-2024",
        modifiedOn: "12-10-2024",
        currentBirdCount: double.parse(34000.toString()),
        type: "Deep Litre",
        mortality: 120,
        acquiredOn: "12-10-2024",
        stage: "Pre Layer Stage", // Operation Stage,
        stock: 123000),
    Flock(
        id: 1,
        batchName: "1202202401",
        coopName: "Gianna House",
        author: "Muyinda ROgers",
        status: "Active",
        createdOn: "12-10-2024",
        modifiedOn: "12-10-2024",
        currentBirdCount: double.parse(34000.toString()),
        type: "Deep Litre",
        mortality: 120,
        acquiredOn: "12-10-2024",
        stage: "Pre Layer Stage", // Operation Stage,
        stock: 123000),
    Flock(
        id: 1,
        batchName: "1202202401",
        coopName: "Gianna House",
        author: "Muyinda ROgers",
        status: "Active",
        createdOn: "12-10-2024",
        modifiedOn: "12-10-2024",
        currentBirdCount: double.parse(34000.toString()),
        type: "Deep Litre",
        mortality: 120,
        acquiredOn: "12-10-2024",
        stage: "Pre Layer Stage", // Operation Stage,
        stock: 123000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search flock...',
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
                  "🐓 Flock Management",
                  style: TextStyle(
                    fontFamily: AppConstants.defaultFont,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )),
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
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300), // fade animation duration
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _isExpanded
                  ? Container(
                      child: Wrap(
                        children: [
                          // _isExpanded
                          SizedBox(
                            height: 10,
                          ),
                          getHeaderWidget(context),
                          SizedBox(
                            height: 10,
                          ),
                          this.coops.isNotEmpty
                              ? Wrap(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Coops",
                                        style: TextStyle(
                                            fontFamily:
                                                AppConstants.defaultFont,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownSearch<CoopResponse>(
                                          items: coops,
                                          itemAsString: (CoopResponse? coop) =>
                                              coop?.name ??
                                              "", // Display coop name
                                          popupProps: PopupProps.menu(
                                            showSearchBox: true,
                                            searchFieldProps: TextFieldProps(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                            fit: FlexFit.loose,
                                            constraints:
                                                BoxConstraints(maxHeight: 300),
                                            // White dropdown background
                                          ),
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              labelText: "Select Coop",
                                              filled: true,
                                              fillColor: Colors.grey.shade100,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 16),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedCoop =
                                                  value; // store selected coop
                                            });
                                            print(
                                                "You selected ${value?.name}");
                                          },
                                          selectedItem: selectedCoop,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  child: this._coopsLoaded == false
                                      ? GhostLoaderWidget(nums: 1,)
                                      : Text("No Data"),
                                ),

                          // :  SizedBox.shrink()
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ),
            Expanded(
                child: ListView.builder(
              controller: _scrollController,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return FlockListTyle(
                  flock: items[index],
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped ${items[index]}')),
                    );
                  },
                );
                // return ListTile(
                //   title: Text('Item ${index + 1}'),
                // );
              },
            )),

            /*    const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                // child: SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                child: PaginatedDataTable(
                    // header: Text("Manage Farm Profiles"),
                    rowsPerPage: 2,
                    columnSpacing: 40,
                    headingRowColor:
                        WidgetStateProperty.all(Colors.blueGrey.shade700),
                    columns: [
                      // DataColumn(label: Text('Account', style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('Name',
                              style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('Status',
                              style: TextStyle(color: Colors.white))),
                      // DataColumn(label: Text('Author', style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('Date Created',
                              style: TextStyle(color: Colors.white))),
                      DataColumn(
                          label: Text('Action',
                              style: TextStyle(color: Colors.white))),
                    ],
                    source: _farmDataSource
                    //FarmDataSource(filteredData: _filteredData),
                    )

                // ),
                ),
          ),
          */
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Your action here
        },
        icon: Icon(Icons.add),
        label: Text("Add"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      /* bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // View action
                },
                icon: Icon(Icons.visibility),
                label: Text("View"),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Edit action
                },
                icon: Icon(Icons.edit),
                label: Text("Edit"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Delete action
                },
                icon: Icon(Icons.delete),
                label: Text("Delete"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ],
        ),
      ),
      */
    );
  }



  Farm defaultFarm = Farm(id: 01, name: "N/A", isDefault: true, details: '');
  Widget getHeaderWidget(BuildContext context) {
    if (loading == true) {
      return GhostLoaderWidget(nums: 1,);
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
}

