import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  // User Authentication
  static Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // Fetch User Profile
  static Future<Map<String, dynamic>?> getProfile(int userId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // Update User Profile
  static Future<bool> updateProfile(int userId, Map<String, String> profileData, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profile/$userId'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode(profileData),
    );
    
    return response.statusCode == 200;
  }

  // Fetch Financial Goals
  static Future<List<dynamic>?> getFinancialGoals(int userId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/financial-goal/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // Create Financial Goal
  static Future<bool> createFinancialGoal(int userId, Map<String, dynamic> goalData, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/financial-goal/$userId'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode(goalData),
    );
    
    return response.statusCode == 201;
  }
}
