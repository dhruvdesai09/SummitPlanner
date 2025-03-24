import 'package:flutter/material.dart';
// ignore: unused_import
import 'login_screen.dart';
import '../services/api_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signup() async {
    String username = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      bool success = await ApiService.signup(username, email, password);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup Successful! Please login.')),
        );
        Navigator.pop(context); // Go back to login screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed! Try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 App Branding
            Text("Summit Planner", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Your Financial Wellness Partner", style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 40),

            // 🔹 Full Name Input
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 15),

            // 🔹 Email Input
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 15),

            // 🔹 Password Input
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            // 🔹 Signup Button
            ElevatedButton(
              onPressed: _signup,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("Sign Up", style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),

            // 🔹 Navigation to Login
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Go back to login screen
              },
              child: Text("Already have an account? Login", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
