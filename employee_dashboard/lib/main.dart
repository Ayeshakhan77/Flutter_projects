import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/project_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/leave_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(EmployeeDashboardApp());
}

class EmployeeDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Employee Dashboard",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.light(
          primary: Color(0xff5B67F2),
          secondary: Color(0xff8E9CFF),
        ),

        scaffoldBackgroundColor: Color(0xffF4F6FF),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),

      initialRoute: AppRoutes.home,

      routes: {
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.profile: (context) => ProfileScreen(),
        AppRoutes.projects: (context) => ProjectScreen(),
        AppRoutes.attendance: (context) => AttendanceScreen(),
        AppRoutes.leave: (context) => LeaveScreen(),
        AppRoutes.settings: (context) => SettingsScreen(),
      },
    );
  }
}