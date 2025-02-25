import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isExpanded = false;

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
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isExpanded ? 200 : 70,
            decoration: const BoxDecoration(
              color: Color(0XFFDBE3DD),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),  // Top-right corner
                bottomRight: Radius.circular(20), // Bottom-right corner
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildMenuItem(Icons.home, "Home"),
                _buildMenuItem(Icons.dashboard, "Dashboard"),
                _buildMenuItem(Icons.settings, "Settings"),
                _buildMenuItem(Icons.person, "Profile"),
                _buildMenuItem(Icons.logout, "Logout"),
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
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
