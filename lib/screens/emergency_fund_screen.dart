import 'package:flutter/material.dart';

class EmergencyFundScreen extends StatelessWidget {
  const EmergencyFundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Fund"),
        backgroundColor: Colors.blue[800],
      ),
      body: const Center(
        child: Text(
          "Emergency Fund Strategy Coming Soon!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
