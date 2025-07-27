import 'dart:convert';
import 'package:Cooply/models/dtos/message_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dtos/loginResponse.dart';

import '../utils/AppConstants.dart';
import '../utils/log_service.dart';
import 'package:dio/dio.dart'; //import dio in exchange for http

class AuthService {
  final String baseUrl = "${AppConstants.BASE_URL}${AppConstants.AUTHENDPOINT}";
  final String baseApi = "${AppConstants.BASE_URL}v1";

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
    try {
    final response = await initDio(AppConstants.BASE_URL).post(
      'v1/auth/register',
      data: jsonEncode({
        "username": username,
        "password": password,
      }),
    );
    print("Status Code: ${response.statusCode}");

    return response.statusCode == 201; // return a boolean
    } on DioException catch (e) {
      print("Login failed: ${e.response?.statusCode} - ${e.message}");

      // Optionally, log more information like the error stack trace
      print("Stack Trace: ${e.stackTrace}");
      return false;
    }
  }

  Future<LoginResponse?> loginUser(String username, String password) async {
    print("Method Login User");

    try {
      final response = await initDio(AppConstants.BASE_URL).post(
        '/v1/auth/login', // Using relative path for better maintainability
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



  Future<MessageResponse?> validateToken(String token) async {
    print("Method Validate OTP");

    try {
      final response = await initDio(AppConstants.BASE_URL).post(
        '/v1/auth/validate/otp',
        data: {"token": token}, // No need for jsonEncode if Dio is handling JSON
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {

        return MessageResponse(
            message: "Account Activated Succesfuly",
            status: "approved"
        );
      }

      return MessageResponse(
        message: "Was not able to successfully validate the OTP.",
        status: "declined"
      );
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");
      print("Response Data: ${e.response?.data}");
      return MessageResponse(
          message: "OTP validation failed. Please try again.",
        status: "declined"
      );
    } catch (e) {
      print("Unexpected error: $e");
      return MessageResponse(
          message: "An unexpected error occurred.",
      status: "declined");
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
