import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue),
            title: Text("You reached 80% of your emergency fund goal!"),
            subtitle: Text("2 hours ago"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.trending_up, color: Colors.green),
            title: Text("New investment opportunity: PPF now at 7.1%"),
            subtitle: Text("Yesterday"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.warning, color: Colors.red),
            title: Text("Overspending alert: Entertainment category"),
            subtitle: Text("3 days ago"),
          ),
        ],
      ),
    );
  }
}
