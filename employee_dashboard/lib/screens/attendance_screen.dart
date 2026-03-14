import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text("Attendance")),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(

          children: [

            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text("Days Present"),
                trailing: Text("22"),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.cancel, color: Colors.red),
                title: Text("Leaves Taken"),
                trailing: Text("2"),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.beach_access, color: Colors.orange),
                title: Text("Holidays"),
                trailing: Text("5"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}