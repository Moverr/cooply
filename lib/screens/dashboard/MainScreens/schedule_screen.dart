import 'dart:convert';

import 'package:Cooply/cards/schedule_card.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/dtos/Farm.dart';
import '../../../models/dtos/feed_inventory.dart';
import '../../../models/dtos/loginResponse.dart';
import '../../../models/dtos/schedule.dart';
import '../../../services/farm_service.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScheduleState();
}

class _ScheduleState extends State<ScheduleScreen> {
  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> _filteredData = [];

  late FarmDataSource _farmDataSource;
  final FarmService _farmService = FarmService();

  @override
  void initState() {
    super.initState();
    _farmDataSource = FarmDataSource(context);
    _farmDataSource.fetchPage(0);
  }

  FarmDataSource Function(BuildContext, LoginResponse) initFarmDataSource =
      (context, loginResponse) => FarmDataSource(context);

  // Separate async method for initialization
  Future<void> _initializeData() async {
    await loadUser(); // Wait for loginResponse to be ready
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

  final List<FeedInventory> items = [
    FeedInventory(
        id: 1,
        batchId: "1202202401",
        quantity: 12344,
        availableQuantity: 12344,
        transactionType: "ADDITION", //ADDITION,REDUCTION
        farm: "Mwamba Farm",
        flock: "BN:1234567", //?? which coop

        author: "Muyinda ROgers",
        registeredDate: "12-10-2024",
        createdOn: "12-10-2024",
        modifiedOn: "12-10-2024",
        items: [
          FeedInventoryLog(
              id: 1,
              itemName: "Maize",
              quantity: 1000, //consumed or added
              availableQuantity: 1100,
              transactionType: "ADDITION")
        ]),
    FeedInventory(
        id: 1,
        batchId: "1202202401",
        quantity: 12344,
        availableQuantity: 12344,
        transactionType: "ADDITION", //ADDITION,REDUCTION
        farm: "Mwamba Farm",
        flock: "BN:1234567", //?? which coop

        author: "Muyinda ROgers",
        registeredDate: "12-10-2024",
        createdOn: "12-10-2024",
        modifiedOn: "12-10-2024",
        items: [
          FeedInventoryLog(
              id: 1,
              itemName: "Maize",
              quantity: 1000, //consumed or added
              availableQuantity: 1100,
              transactionType: "ADDITION")
        ]),
  ];

  String selectedValue = 'Apple';
  final List<String> dropDownItems = ['Apple', 'Banana', 'Mango', 'Orange'];

  List<Schedule> schedules = [
    Schedule(
        id: 1
        ,scheduleDate:DateTime.now().add(Duration(days: -1))
        ,farm: "Samba Farm"
        ,coop: "Bilungo"
        ,type: "Farm Visit"
        ,from: DateTime.now().add(Duration(days: -1))
        ,to:DateTime.now().add(Duration(days: 2))
        ,priority: "low"
        ,assignedTo: "Muyinda Rogers"
        ,status: TaskStatus.pending
    ),

    Schedule(
        id: 1
        ,scheduleDate:  DateTime.now().add(Duration(days: -3))
        ,farm: "Zamba Farm"
        ,coop: "0001BNXY"
        ,type: "Vaccination"
        ,from: DateTime.now().add(Duration(days: -3))
        ,to:DateTime.now().add(Duration(days: -1))
        ,priority: "high"
        ,assignedTo: "Muyinda Rogers"
        ,status: TaskStatus.missed
    ),

    Schedule(
        id: 1
        ,scheduleDate: DateTime.now()
        ,farm: "Mwamba Farm"
        ,coop: "Ginanna"
        ,type: "Vaccination"
        ,from: DateTime.now()
        ,to:DateTime.now()
        ,priority: "high"
        ,assignedTo: "Muyinda Rogers"
        ,status: TaskStatus.rescheduled
    ),

    Schedule(
        id: 1
        ,scheduleDate: DateTime.now()
        ,farm: "Mwamba Farm"
        ,coop: "Ginanna"
        ,type: "Vaccination"
        ,from: DateTime.now()
        ,to:DateTime.now()
        ,priority: "high"
        ,assignedTo: "Muyinda Rogers"
        ,status: TaskStatus.finished
    ),

    Schedule(
        id: 1
        ,scheduleDate: DateTime.now()
        ,farm: "Mwamba Farm"
        ,coop: "Ginanna"
        ,type: "Vaccination"
        ,from: DateTime.now()
        ,to:DateTime.now()
        ,priority: "high"
        ,assignedTo: "Muyinda Rogers"
        ,status: TaskStatus.skipped
    ),





  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          // padding: EdgeInsets.all(10),
          width: double.infinity,
          // color: Colors.green.shade300,
          child: Text("Schedule") ,
        ),
       
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: schedules.map((item) => ScheduleCard(item)).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Your action here
        },
        icon: Icon(Icons.add),
        label: Text("Add"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

      farms = response!.content.cast<Farm>();
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
