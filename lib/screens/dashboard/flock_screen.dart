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
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/dtos/farm.dart';
import '../../services/FarmService.dart';
import '../../utils/util.dart';
import '../../widgets/coopListTyle.dart';
import '../../widgets/custom_expansion_tile.dart';

class FlockScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlockState();
}

class _FlockState extends State<FlockScreen> {
  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> _filteredData = [];

  late FarmDataSource _farmDataSource;
  final FarmService _farmService = FarmService();

  final GlobalKey expansionTileKey = GlobalKey();
  bool _isExpanded = false;

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _farmDataSource = FarmDataSource(context);
    _farmDataSource.fetchPage(0);
    /*
    loadUser();

    _farmDataSource = FarmDataSource(context,loginResponse);
     _farmDataSource.fetchPage(0);
     */

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //
    // });
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

  late LoginResponse? loginResponse;
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
    _initializeData();

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
            : Text(
                "🐓 Flock Management",
                style: TextStyle(
                  fontFamily: AppConstants.defaultFont,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
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
          IconButton(
            icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomExpansionTile(
              expanded: _isExpanded,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
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
                            labelText: "Select Farm",
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
                        onChanged: (value) => print("You selected $value"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
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
                        onChanged: (value) => print("You selected $value"),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
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
      final response = await farmService.fetchFarms(
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

