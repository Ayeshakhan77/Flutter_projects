import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class NavigationLayout extends StatefulWidget {
  final Widget body;

  NavigationLayout({required this.body});

  @override
  State<NavigationLayout> createState() => _NavigationLayoutState();
}

class _NavigationLayoutState extends State<NavigationLayout> {

  int index = 0;

  final routes = [
    AppRoutes.home,
    AppRoutes.projects,
    AppRoutes.attendance,
    AppRoutes.profile,
    AppRoutes.settings
  ];

  void navigate(int i) {
    setState(() {
      index = i;
    });

    Navigator.pushNamed(context, routes[i]);
  }

  @override
  Widget build(BuildContext context) {

    bool largeScreen = MediaQuery.of(context).size.width > 700;

    return Scaffold(
      body: Row(
        children: [

          if (largeScreen)
            NavigationRail(
              selectedIndex: index,
              onDestinationSelected: navigate,
              labelType: NavigationRailLabelType.all,

              destinations: const [

                NavigationRailDestination(
                    icon: Icon(Icons.dashboard), label: Text("Dashboard")),

                NavigationRailDestination(
                    icon: Icon(Icons.work), label: Text("Projects")),

                NavigationRailDestination(
                    icon: Icon(Icons.access_time), label: Text("Attendance")),

                NavigationRailDestination(
                    icon: Icon(Icons.person), label: Text("Profile")),

                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: Text("Settings")),
              ],
            ),

          Expanded(child: widget.body)
        ],
      ),

      bottomNavigationBar: !largeScreen
          ? BottomNavigationBar(
              currentIndex: index,
              onTap: navigate,
              type: BottomNavigationBarType.fixed,
              items: const [

                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: "Home"),

                BottomNavigationBarItem(
                    icon: Icon(Icons.work), label: "Projects"),

                BottomNavigationBarItem(
                    icon: Icon(Icons.access_time), label: "Attendance"),

                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),

                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
              ],
            )
          : null,
    );
  }
}