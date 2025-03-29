import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dtos/LoginResponse.dart';

import '../utils/AppConstants.dart';



class AuthService {

  final String baseUrl = "${AppConstants.BASE_URL}${AppConstants.AUTHENDPOINT}";

  Future<bool> register(String username, String password) async {
    final url = Uri.parse('$baseUrl${AppConstants.REGISTER}');

    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    return response.statusCode == 201; // 201 means user registered successfully
  }

  Future<LoginResponse?> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['is_successful']) {
        LoginResponse loginResponse = LoginResponse.fromJson(data);

        // Store the entire JSON response
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('login_response', jsonEncode(data));


        print("Login Success: ${loginResponse.authToken}");
        return loginResponse;
      }
    }

    print("Login Failed: ${response.body}");
    return null;
  }

  Future<void> logout() async {

    //todo: register logout session for the user
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_response');
    print("Logged out successfully!");
  }

  Future<LoginResponse?> getStoredLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('login_response');

    if (jsonString != null) {
      return LoginResponse.fromJson(jsonDecode(jsonString));
    }
    return null;
  }
}
