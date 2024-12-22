import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000'; // Replace with your backend URL

  // Login API
  Future<String> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'role': 'Investor', // Role for contributors
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token']; // Return JWT token for further use
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // Signup API
  Future<void> signup(String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
        'role': 'Investor', // Role for contributors
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to signup: ${response.body}');
    }
  }
}
