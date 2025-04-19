import 'package:flutter/material.dart';

class FinancialSummaryScreen extends StatelessWidget {
  const FinancialSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Financial Summary"),
        backgroundColor: Colors.blue[800],
      ),
      body: const Center(
        child: Text(
          "Detailed Financial Summary View Coming Soon!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
