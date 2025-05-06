import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/dtos/Farm.dart';
import '../../services/FarmService.dart';

class FarmSetupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FarmSetupSate();
}

class _FarmSetupSate extends State<FarmSetupScreen> {

  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> _filteredData = [];


  late FarmDataSource _farmDataSource;
  final FarmService _farmService = FarmService();




  @override
  void initState() {
    super.initState();
    // Initially, show all data
    // _filteredData = _dataSource.getData();
    // _searchController.addListener(_filterData);


    _farmDataSource = FarmDataSource(context, _farmService);
    _farmDataSource.fetchPage(0);

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Farm Management",
          style: TextStyle(
              fontFamily: AppConstants.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body:Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Padding(padding: EdgeInsets.all( 16.0),
            child:   const Text(
              "Manage Farms",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

           const SizedBox(height: 20),



          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              // child: SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
                child:  PaginatedDataTable(
                  // header: Text("Manage Farm Profiles"),
                  rowsPerPage: 10,
                  columnSpacing: 40,
                  headingRowColor:  WidgetStateProperty.all(Colors.blueGrey.shade700),
                  columns: [
                    // DataColumn(label: Text('Account', style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text('Name', style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text('Status', style: TextStyle(color: Colors.white))),
                    // DataColumn(label: Text('Author', style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text('Date Created', style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text('Action', style: TextStyle(color: Colors.white))),
                  ],
                  source:_farmDataSource
                  //FarmDataSource(filteredData: _filteredData),
                )
                
                

                // ),
              ),
            ),


        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Your action here
        },
        icon: Icon(Icons.add),
        label: Text("Add"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,



      bottomNavigationBar: Container(
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


    );
  }
}

class FarmDataSource extends DataTableSource{


  final BuildContext context;
  final FarmService farmService;
  List<Farm> farms = [];
  int totalRows = 0;
  int rowsPerPage = 5;
  int page = 0;

  FarmDataSource(this.context, this.farmService);

  Future<void> fetchPage(int pageIndex) async {
    final offset = pageIndex * rowsPerPage;
    try {
      final response = await farmService.fetchFarms(
        accountId: 16,
        offset: offset,
        limit: rowsPerPage,
      );

      farms = response.content;
      totalRows = response.totalElements;
      page = response.pageNumber;

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







  final List<Map<String, String>> _data = List.generate(100, (index) => {
    'account': 'Default',
    'name': 'Default Farm ',
    'status': 'Active',
    'author': 'M Rogers',
    'dateCreated': '2204-01-13',
    'action': 'Action',
  });




  @override
  DataRow? getRow(int index) {
    if (index >= farms.length) return null;
    final farm = farms[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(farm.id.toString())),
      DataCell(Text(farm.name)),
      DataCell(Text(farm.author)),
      // DataCell(Text(farm.status ?? 'N/A')),
    ]);
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
