import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text("Account Settings"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to account settings
              },
            ),
            ListTile(
              title: Text("Notification Preferences"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to notification settings
              },
            ),
            // Add more settings options here
          ],
        ),
      ),
    );
  }
}
