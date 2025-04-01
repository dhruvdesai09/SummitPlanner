import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      appBar: AppBar(
        title: const Text("Summit Planner"),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Notification click action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            financialSummaryCard(),
            const SizedBox(height: 10),
            budgetInsightsCard(),
            const SizedBox(height: 10),
            microInvestmentCard(),
            const SizedBox(height: 10),
            emergencyFundCard(),
          ],
        ),
      ),
    );
  }

  Widget financialSummaryCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Financial Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("₹XXXX", style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Available: ₹X"),
                Text("Income: ₹Y"),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 5),
            const Text("Progress Bar: Emergency Fund", style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget budgetInsightsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Budget Insights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            budgetItem(Icons.restaurant, "Food: 25%", Colors.orange),
            budgetItem(Icons.directions_car, "Travel: 15%", Colors.purple),
            budgetItem(Icons.warning, "Cut ₹500 from Subscriptions", Colors.red),
            budgetItem(Icons.calendar_today, "Upcoming Bills: ₹Y on March 30", Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget microInvestmentCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Micro-investment Plan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            budgetItem(Icons.monetization_on, "FD (6%)", Colors.green),
            budgetItem(Icons.show_chart, "Mutual Funds", Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget emergencyFundCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Emergency Fund", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            budgetItem(Icons.rocket, "Save ₹Z per month to reach goal", Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget budgetItem(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 16, color: color)),
        ],
      ),
    );
  }
}
