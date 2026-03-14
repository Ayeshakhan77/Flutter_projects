import 'package:flutter/material.dart';

class LeaveScreen extends StatelessWidget {

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Leave Request"),
      ),

      body: Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(

              controller: controller,

              decoration: InputDecoration(
                labelText: "Reason for Leave",
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(

              onPressed: () {

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Leave Request Submitted")));
              },

              child: Text("Submit Request"),
            ),
          ],
        ),
      ),
    );
  }
}