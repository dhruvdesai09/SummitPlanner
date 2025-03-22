import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000'; // Emulator-friendly URL

    // 🔹 User Signup
  static Future<bool> signup(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "email": email, "password": password}),
    );
    return response.statusCode == 200;
  }

  // 🔹 User Authentication
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    return _handleResponse(response);
  }

  // 🔹 Fetch User Profile
  static Future<Map<String, dynamic>?> getProfile(int userId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/profile/$userId'),
      headers: _authHeaders(token),
    );
    return _handleResponse(response);
  }

  // 🔹 Update User Profile
  static Future<bool> updateProfile(int userId, Map<String, dynamic> profileData, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/profile/$userId'),
      headers: _authHeaders(token),
      body: jsonEncode(profileData),
    );
    return response.statusCode == 200;
  }

  // 🔹 Fetch Financial Goals
  static Future<List<dynamic>?> getFinancialGoals(int userId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/financial/goals/$userId'),
      headers: _authHeaders(token),
    );
    return _handleResponse(response);
  }

  // 🔹 Create Financial Goal
  static Future<bool> createFinancialGoal(int userId, Map<String, dynamic> goalData, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/financial/goals/$userId'),
      headers: _authHeaders(token),
      body: jsonEncode(goalData),
    );
    return response.statusCode == 201;
  }

  // 🔹 Delete Financial Goal
  static Future<bool> deleteFinancialGoal(int goalId, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/financial/goals/$goalId'),
      headers: _authHeaders(token),
    );
    return response.statusCode == 200;
  }

  // 📌 Utility: Handle API Responses
  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // 📌 Utility: Authentication Headers
  static Map<String, String> _authHeaders(String token) {
    return {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  }
}
