import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dtos/LoginResponse.dart';

import '../utils/AppConstants.dart';
import '../utils/log_service.dart';
import 'package:dio/dio.dart'; //import dio in exchange for http

class AuthService {
  final String baseUrl = "${AppConstants.BASE_URL}${AppConstants.AUTHENDPOINT}";
  final String baseApi = "http://52.207.255.31:8082/v1";

  initDio(String baseUrl) => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10), // Timeout for connection
          receiveTimeout:
              const Duration(seconds: 10), // Timeout for receiving data
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
          },
        ),
      );

  Future<bool> registerUser(String username, String password) async {
    final response = await initDio("http://52.207.255.31:8082/v1").post(
      '/register',
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    return response.statusCode == 201; // return a boolean
  }

  Future<LoginResponse?> loginUser(String username, String password) async {
    print("Method Login User");

    try {
      final response = await initDio("http://52.207.255.31:8082/v1").post(
        '/auth/login', // Using relative path for better maintainability
        data: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Data: ${response.data}");

        final prefs = await SharedPreferences.getInstance();

        // You can store the login response in SharedPreferences for future use
        // Example: Store the token or the entire response
        await prefs.setString('login_response', jsonEncode(response.data));

        // Map<String, dynamic> jsonMap = jsonDecode(response.data);
        Map<String, dynamic> jsonMap = response.data is Map ? response.data : jsonDecode(response.data);

        // LogService.info(response.data);

        LoginResponse loginResponse = LoginResponse.fromJson(jsonMap);
        return loginResponse;
      }

      // Handle non-200 responses here, e.g., show a message to the user
      return null;
    } on DioException catch (e) {
      print("Login failed: ${e.response?.statusCode} - ${e.message}");

      // Optionally, log more information like the error stack trace
      print("Stack Trace: ${e.stackTrace}");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('login_response', ''); // Clear the saved login data on failure

      // You might want to propagate a more detailed error message here
      return null; // Handle error gracefully
    }
  }

  Future<void> logout() async {
    //todo: register logout session for the user
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_response');
    LogService.info("Logged out successfully!");
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
