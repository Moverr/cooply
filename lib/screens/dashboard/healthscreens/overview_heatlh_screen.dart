import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../cards/health_overview_card.dart';
import '../../../models/dtos/feed_inventory.dart';
import '../../../utils/util.dart';

class OverviewHealthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OverviewHealthState();
}

class _OverviewHealthState extends State<OverviewHealthScreen> {
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

  final List<String> tableHeaders = [
    "FLOCK","SICK","MORTALITY","LAST VAC","NEXT VAC"
  ];

  final List<Map<String, dynamic>> data = List.generate(50, (index) {
    return {
      "flock": " BN 112/1234/12",
      "sick": 20 + index % 10,
      "mortality": 20 + index % 10,
      "last_vaccine": index % 2 == 0 ? "12/234/12" : "32/4/45",
      "next_vaccine": index % 2 == 0 ? "12/234/12" : "32/4/45",
    };
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: ListView(
      children: [
        Container(
          padding:   EdgeInsets.only(left: Util.scaleWidthFromDesign(context,15.0), top: Util.scaleWidthFromDesign(context,10)),
          alignment: Alignment.centerLeft,
          child: Text("  May 15th   - May 20th"),
        ),
        Padding(
          //top View
          padding:   EdgeInsets.all(Util.scaleWidthFromDesign(context,16.0)),
          child: SizedBox(
            height: Util.scaleWidthFromDesign(context,210), // height of each horizontal item
            child: ListView(scrollDirection: Axis.horizontal, children: [
              HealthOverviewCard("Mortality", "120", 0XFFCF6B57, "2%"),
              HealthOverviewCard("Sick", "15", 0XFFEBC774, "10%"),
              HealthOverviewCard("  Flock", "9.5K", 0XFF75A9A0, "99%"),
              HealthOverviewCard("Vaccination", "12", 0XFF75A978, "50%")
            ]),
          ),
        ),
        Padding(
          //Bottom Item
          padding:   EdgeInsets.all( 1.0),
          child: SingleChildScrollView(
              child: SingleChildScrollView(
                  child: Theme(
            data: Theme.of(context).copyWith(
              cardColor: Colors.white,
              dataTableTheme: DataTableThemeData(
                headingRowColor: WidgetStateProperty.all(Color(0XFFF9F7EE)),
                headingTextStyle:   TextStyle(

                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: Util.scaleWidthFromDesign(context,7),
                  fontFamily: AppConstants.fontFamily,
                  letterSpacing:Util.scaleWidthFromDesign(context,1)


                ),
                dataRowColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.white;
                  },
                ),
                dataTextStyle:   TextStyle(
                  color: Colors.black,
                  fontSize: Util.scaleWidthFromDesign(context,8),
                ),
              ),
            ),
            child: PaginatedDataTable(
              // header: const Text('User Info'),
              columns: tableHeaders.map(
                  (item) => DataColumn(label: Text(item)))
              .toList()
              ,

              source: MyDataSource(data),
              rowsPerPage: 5,
              columnSpacing: Util.scaleWidthFromDesign(context,2),
                showCheckboxColumn:true,
            ),
          ))


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

    );

  }
}

class MyDataSource extends DataTableSource {


  final List<Map<String, dynamic>> _originalData;
  List<Map<String, dynamic>> _filteredData;


  MyDataSource(this._originalData) : _filteredData = List.from(_originalData);




  void filterData(String query) {
    _filteredData = _originalData
        .where((row) =>
        row.values.any((value) =>
            value.toString().toLowerCase().contains(query.toLowerCase())))
        .toList();
    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(Map<String, dynamic> d) getField, bool ascending) {
    _filteredData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }


  @override
  DataRow getRow(int index) {
    final row = _filteredData[index];

    return DataRow.byIndex(
      index: index,
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          // if (index % 2 == 0) return Colors.grey.shade200;
          return Colors.white;
        },
      ),
      cells: [
        DataCell(Text(row["flock"])),
        DataCell(Text(row["sick"].toString())),
        DataCell(Text(row["mortality"].toString())),
        DataCell(Text(row["last_vaccine"].toString())),
        DataCell(Text(row["next_vaccine"].toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _filteredData.length;

  @override
  int get selectedRowCount => 0;
}
