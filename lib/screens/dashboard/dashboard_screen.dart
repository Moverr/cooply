import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text("Dashboard"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
        ),
      ),
      */
      body: Center(
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isExpanded ? 150 : 50,
              decoration: const BoxDecoration(
                color: Color(0XFFDBE3DD),
                // boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 0)],
                /* borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),  // Top-right corner
                bottomRight: Radius.circular(20), // Bottom-right corner
              ),
              */
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Container(
                      width:
                          isExpanded ? 150 : 50, // Sidebar expands or collapses
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.max, // Prevents overflow
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/chicken.png",
                            height: 40,
                            width: 40,
                          ),
                          if (isExpanded) ...[

                            Expanded(
                              // <-- FIX: Forces text to fit within available space
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                    overflow: TextOverflow
                                        .ellipsis, // Prevents text overflow
                                    maxLines: 1,
                                  ),
                                  Text(
                                    "Muyinda Rogers",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  _MenuItem("assets/overview.png", "Overview"),
                  _MenuItem("assets/farm.png", "Farm"),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Center(
                child: Text(
                  isExpanded ? "Sidebar Expanded" : "Sidebar Minimized",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _MenuItem(String asset, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        width: isExpanded ? 150 : 50, // Sidebar expands or collapses
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min, // Prevents overflow
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              asset,
              height: 40,
              width: 40,
            ),
            if (isExpanded) ...[

              Expanded(
                // <-- FIX: Forces text to fit within available space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                      overflow: TextOverflow.ellipsis, // Prevents text overflow
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return InkWell(
      onTap: () {},
      child: Center(
        // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 24,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(
                    icon,
                    color: Colors.white,
                  ),
                )),
            if (isExpanded) const SizedBox(width: 10),
            if (isExpanded)
              SizedBox(
                width: 100,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
