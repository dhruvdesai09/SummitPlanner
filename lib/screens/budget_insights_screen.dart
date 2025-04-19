import 'package:flutter/material.dart';

class BudgetInsightsScreen extends StatelessWidget {
  const BudgetInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Insights"),
        backgroundColor: Colors.blue[800],
      ),
      body: const Center(
        child: Text(
          "Budget Insights Details Coming Soon!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
