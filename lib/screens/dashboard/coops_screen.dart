
import 'package:Cooply/models/dtos/coop_response.dart';
import 'package:Cooply/models/dtos/loginResponse.dart';
import 'package:Cooply/services/coop_service.dart';
import 'package:Cooply/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/dtos/farm.dart';
import '../../models/dtos/requests/farm_request.dart';
import '../../services/farm_service.dart';
import '../../services/service_result.dart';
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
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmLocationController = TextEditingController();
  final TextEditingController _farmDetailsController = TextEditingController();

  TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> _filteredData = [];

  bool _isSearching = false;

  //todo: getting the farm data
  Farm defaultFarm =
      new Farm(id: 01, name: "N/A", isDefault: true, details: '');
  bool existingFarms = false;
  bool loading = false;
  FarmService fmService = FarmService();
  CoopService cpService = CoopService();

  late List<Farm> farms = [];
  late List<CoopResponse> coops = [];

  late LoginResponse loginResponse;

  @override
  void initState() {
    super.initState();
    loginResponse = widget.loginResponse!;

    getDefaultFarm();
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
        .then((PaginatedFarmsResponse? farmsResponse) {
      setState(() {
        loading = false;
        if (farmsResponse!.content.isNotEmpty) {
          existingFarms = true;
          farms = farmsResponse.content;

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
      offset: 0,
      limit: 20,
      loginResponse: loginResponse,
    )
        .then((List<CoopResponse> coopResponseList) {
      setState(() {
        if (coopResponseList.isNotEmpty) {
          this.coops = coopResponseList;
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
                child:
               coops.length == 0 ?
                getGhostWidget(context)
                // ListView.builder(
                //   itemCount: 5,
                //   itemBuilder: (context, index){
                //     getGhostWidget(context);
                //   },
                // )

                    :
                ListView.builder(
              itemCount: coops.length,
              itemBuilder: (context, index) {
                return CoopListTyle(
                  coop: coops[index],
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped ${coops[index].name}')),
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
                      "Create Coop",
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
                            addresses: [],
                          );

                          // Show loading
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                                child: CircularProgressIndicator()),
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
