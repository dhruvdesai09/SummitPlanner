import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Replace this with your actual API endpoint
const String apiUrl = "http://10.0.2.2:8000/api/home-summary";

class HomeData {
  final double available;
  final double income;
  final double emergencyFundProgress;
  final List<Map<String, dynamic>> budgetItems;
  final List<Map<String, dynamic>> investments;
  final String emergencyTip;

  HomeData({
    required this.available,
    required this.income,
    required this.emergencyFundProgress,
    required this.budgetItems,
    required this.investments,
    required this.emergencyTip,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      available: json['available'],
      income: json['income'],
      emergencyFundProgress: json['emergencyFundProgress'],
      budgetItems: List<Map<String, dynamic>>.from(json['budgetItems']),
      investments: List<Map<String, dynamic>>.from(json['investments']),
      emergencyTip: json['emergencyTip'],
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String email;
  const HomeScreen({super.key, required this.email});

  Future<HomeData> fetchHomeData() async {
    final response = await http.get(Uri.parse('$apiUrl?email=$email'));
    if (response.statusCode == 200) {
      return HomeData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load home data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Summit Planner"),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile', arguments: email);
            },
          ),
        ],
      ),
      body: FutureBuilder<HomeData>(
        future: fetchHomeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final data = snapshot.data!;
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    financialSummaryCard(data.available, data.income, data.emergencyFundProgress),
                    const SizedBox(height: 10),
                    budgetInsightsCard(data.budgetItems),
                    const SizedBox(height: 10),
                    microInvestmentCard(data.investments),
                    const SizedBox(height: 10),
                    emergencyFundCard(data.emergencyTip),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chatbot');
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.chat_bubble_outline),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget financialSummaryCard(double available, double income, double progress) {
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
            Text("₹${available.toStringAsFixed(2)}", style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Available: ₹${available.toStringAsFixed(0)}"),
                Text("Income: ₹${income.toStringAsFixed(0)}"),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
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

  Widget budgetInsightsCard(List<Map<String, dynamic>> items) {
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
            ...items.map((item) => budgetItem(item['icon'], item['text'], Color(int.parse(item['color'])))),
          ],
        ),
      ),
    );
  }

  Widget microInvestmentCard(List<Map<String, dynamic>> investments) {
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
            ...investments.map((inv) => budgetItem(inv['icon'], inv['text'], Color(int.parse(inv['color'])))),
          ],
        ),
      ),
    );
  }

  Widget emergencyFundCard(String tip) {
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
            budgetItem(Icons.rocket, tip, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget budgetItem(dynamic icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon is IconData ? icon : Icons.info, color: color, size: 24),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 16, color: color)),
        ],
      ),
    );
  }
}
