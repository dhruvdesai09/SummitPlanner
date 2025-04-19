import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final String email; // Pass email from home screen

  const ProfileScreen({super.key, required this.email});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String incomeLevel = '';
  String currency = '';

  Future<void> updateProfile() async {
    // First fetch user ID from email
    final userResponse = await http.get(
      Uri.parse('http://your-backend-url/api/userid/${widget.email}'),
    );

    if (userResponse.statusCode == 200) {
      final userId = int.parse(userResponse.body); // assuming backend returns plain id

      final profileResponse = await http.post(
        Uri.parse('http://your-backend-url/api/updateprofile'),
        body: {
          'user_id': userId.toString(),
          'full_name': fullName,
          'income_level': incomeLevel,
          'currency': currency,
        },
      );

      if (profileResponse.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update profile")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to retrieve user ID")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Full Name"),
                onChanged: (value) => fullName = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Income Level"),
                onChanged: (value) => incomeLevel = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Preferred Currency"),
                onChanged: (value) => currency = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateProfile();
                  }
                },
                child: const Text("Save Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
