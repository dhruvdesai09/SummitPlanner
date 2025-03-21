import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000'; // Emulator-specific URL

  // ✅ User Authentication
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return {};
  }

  static Future<bool> register(String email, String password, String name) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password, "name": name}),
    );
    return response.statusCode == 201;
  }

  // ✅ Fetch User Profile
  static Future<Map<String, dynamic>?> getProfile(int userId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // ✅ Update User Profile
  static Future<bool> updateProfile(int userId, Map<String, dynamic> profileData, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(profileData),
    );

    return response.statusCode == 200;
  }

  // ✅ Fetch Financial Goals
  static Future<List<dynamic>?> getFinancialGoals(int userId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/financial/goals/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // ✅ Create Financial Goal
  static Future<bool> createFinancialGoal(int userId, Map<String, dynamic> goalData, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/financial/goals/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(goalData),
    );

    return response.statusCode == 201;
  }

  // ✅ Update Financial Goal
  static Future<bool> updateFinancialGoal(int goalId, Map<String, dynamic> goalData, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/financial/goals/$goalId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(goalData),
    );

    return response.statusCode == 200;
  }

  // ✅ Delete Financial Goal
  static Future<bool> deleteFinancialGoal(int goalId, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/financial/goals/$goalId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return response.statusCode == 204;
  }
}
