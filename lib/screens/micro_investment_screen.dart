import 'package:flutter/material.dart';

class MicroInvestmentScreen extends StatelessWidget {
  const MicroInvestmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Micro-Investment Plan"),
        backgroundColor: Colors.blue[800],
      ),
      body: const Center(
        child: Text(
          "Micro-Investment Details Coming Soon!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
