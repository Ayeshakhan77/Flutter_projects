import 'package:flutter/material.dart';

class ProjectScreen extends StatelessWidget {

  Widget projectCard(String name, String manager, String status) {

    return Card(
      elevation: 3,

      child: ListTile(

        leading: Icon(Icons.work, color: Colors.indigo),

        title: Text(name),

        subtitle: Text("Manager: $manager"),

        trailing: Chip(
          label: Text(status),
          backgroundColor: Colors.green.shade100,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text("Projects")),

      body: ListView(
        padding: EdgeInsets.all(16),

        children: [

          projectCard("AI Analytics System", "Ahmed Khan", "Active"),

          projectCard("HR Mobile App", "Sara Ali", "Ongoing"),

          projectCard("Finance Dashboard", "Bilal Ahmed", "Planning"),
        ],
      ),
    );
  }
}