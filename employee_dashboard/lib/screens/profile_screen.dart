import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  Widget infoTile(String title, String value, IconData icon) {

    return Card(

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),

      child: ListTile(

        leading: CircleAvatar(
          backgroundColor: Colors.indigo.shade100,
          child: Icon(icon, color: Colors.indigo),
        ),

        title: Text(title),

        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text("Employee Profile")),

      body: ListView(

        padding: EdgeInsets.all(20),

        children: [

          Column(

            children: [

              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/150?img=3"),
              ),

              SizedBox(height: 10),

              Text(
                "Ayesha khan",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),

              Text(
                "Data Scientist",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),

          SizedBox(height: 25),

          infoTile("Employee ID", "EMP102", Icons.badge),

          infoTile("Email", "ayesha@email.com", Icons.email),

          infoTile("Contact", "0300-1234567", Icons.phone),

          infoTile("Department", "AI & Data", Icons.business),

          infoTile("Joining Date", "10 Jan 2024", Icons.calendar_month),
        ],
      ),
    );
  }
}