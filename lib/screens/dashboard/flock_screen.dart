import 'dart:convert';

import 'package:Cooply/models/dtos/accountResponse.dart';
import 'package:Cooply/models/dtos/coop.dart';
import 'package:Cooply/models/dtos/flock.dart';
import 'package:Cooply/models/dtos/loginResponse.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:Cooply/widgets/farmListTyle.dart';
import 'package:Cooply/widgets/flockListTyle.dart';
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
  late FarmDataSource _farmDataSource;
  final FarmService fmService = FarmService();
  final GlobalKey expansionTileKey = GlobalKey();
  bool _isExpanded = true;
  bool _isSearching = false;

  bool existingFarms = false;
  bool loading = false;
  CoopService cpService = CoopService();

  late List<Farm> farms = [];
  late List<CoopResponse> coops = [];

  int offset = 0;
  int limit = 10;

  @override
  void initState() {
    super.initState();
    loginResponse = widget.loginResponse!;
    getDefaultFarm();
    handleScrollEvent();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // safe to use scrollController here
        print('ScrollController attached. Offset: ${_scrollController.offset}');
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        double currentOffset = _scrollController.offset;

        if (currentOffset > 10) {
          if (_isScrollingUp == false && _isExpanded == true) {
            setState(() {
              _isScrollingUp = true;
              _isExpanded = false;
            });
          }
        } else {
          if (_isScrollingUp == true && _isExpanded == false) {
            setState(() {
              _isScrollingUp = false;
              _isExpanded = true;
            });
          }
        }

        print('Scrolling, offset: $currentOffset');
      }
    });

    _farmDataSource = FarmDataSource(context);
    _farmDataSource.fetchPage(0);
  }

  double _lastOffset = 0;
  bool _isScrollingUp = false;

  void handleScrollEvent() {
    double currentOffset = 10;
    if (_scrollController.hasClients) currentOffset = _scrollController.offset;

    if (currentOffset < _lastOffset) {
      // Scrolling up
      if (!_isScrollingUp) {
        setState(() {
          _isScrollingUp = true;
          _isExpanded = false;
        });
        print("Scrolling Up");
      }
    } else if (currentOffset > _lastOffset) {
      // Scrolling down
      if (_isScrollingUp) {
        setState(() {
          _isExpanded = true;
          _isScrollingUp = false;
        });
        print("Scrolling Down");
      }
    }

    _lastOffset = currentOffset;
  }

  Future<void> getDefaultFarm() async {
    setState(() {
      loading = true;
    });

    fmService
        .getDefaultFarm(
            accountId: loginResponse.defaultAccount.id,
            loginResponse: loginResponse)
        .then((Farm? farmsResponse) {
      print("Kooool");
      print(farmsResponse);
      setState(() {
        loading = false;
        if (farmsResponse != null) {
          defaultFarm = farmsResponse;
        }
        //??
        // new Farm(id: 01, name: "N/A", isDefault: true, details: '');
      });
    });
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
    _scrollController.dispose();
    super.dispose();
  }

  FarmDataSource Function(BuildContext, LoginResponse) initFarmDataSource =
      (context, loginResponse) => FarmDataSource(context);

  late LoginResponse loginResponse;

  bool _isLoading = true;

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

  String selectedValue = 'Apple';
  final List<String> dropDownItems = ['Apple', 'Banana', 'Mango', 'Orange'];

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
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Coops",
                              style: TextStyle(
                                  fontFamily: AppConstants.defaultFont,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownSearch<String>(
                                items: dropDownItems,
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      // hintText: "Search farm...",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  fit: FlexFit.loose,
                                  constraints: BoxConstraints(maxHeight: 300),
                                ),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Select Coop",
                                    // hintText: "Choose a farm",
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                onChanged: (value) =>
                                    print("You selected $value"),
                              ),
                            ),
                          ),
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
}

@Deprecated("This is going out ")
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

      farms = response!;
      totalRows = response.length;
      page = response[response.length - 1].id;
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
