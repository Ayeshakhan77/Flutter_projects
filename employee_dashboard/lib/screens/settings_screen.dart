import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool notifications = true;
  bool darkMode = false;
  bool privacyLock = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text("Settings")),

      body: ListView(

        padding: EdgeInsets.all(16),

        children: [

          SwitchListTile(

            title: Text("Enable Notifications"),

            subtitle: Text("Receive updates and alerts"),

            value: notifications,

            onChanged: (val) {
              setState(() {
                notifications = val;
              });
            },
          ),

          SwitchListTile(

            title: Text("Dark Mode"),

            subtitle: Text("Switch app appearance"),

            value: darkMode,

            onChanged: (val) {
              setState(() {
                darkMode = val;
              });
            },
          ),

          SwitchListTile(

            title: Text("Privacy Lock"),

            subtitle: Text("Secure your app with lock"),

            value: privacyLock,

            onChanged: (val) {
              setState(() {
                privacyLock = val;
              });
            },
          ),

          ListTile(

            leading: Icon(Icons.info),

            title: Text("About App"),

            subtitle: Text("Employee Dashboard v1.0"),
          ),
        ],
      ),
    );
  }
}