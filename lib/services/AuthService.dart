import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dtos/LoginResponse.dart';

import '../utils/AppConstants.dart';
import '../utils/log_service.dart';
import 'package:dio/dio.dart'; //import dio in exchange for http


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

//'http://52.207.255.31:8082/v1'
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080/v1',
      connectTimeout: const Duration(seconds: 10), // Timeout for connection
      receiveTimeout: const Duration(seconds: 10), // Timeout for receiving data
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
    ),
  );


  Future<LoginResponse?> loginUser(String username, String password) async {

    print("Method Login User  ");


    try {
      final response = await dio.post(
        '/auth/login', // Using relative path for better maintainability
        data: jsonEncode( {
          "username": username,
          "password": password,
        }),
      );

      print("Status Code   : ${response.statusCode}");
      if(response.statusCode == 200){
        print("Data  : ${response.data}");

        return LoginResponse.fromJson(response.data);
      }
      return null;

    } on DioException catch (e) {
      print("Login failed: ${e.response?.statusCode} - ${e.message}");
      print("Login failed: ${e.response?.statusCode} - ${e.message}");
      return null; // Handle error gracefully
    }
  }


  /*
  *
  LoginResponse? login(String username, String password)  async {
    final url = Uri.parse('http://52.207.255.31:8082/v1/auth/login');

    try {

      final dio =   Dio();


      final response = await dio.post(
        'http://52.207.255.31:8082/v1/auth/login',
        options: Options(
          headers: {
            'accept': '**',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data; //already decoded but how to convert into a dto

        if (data['is_successful']) {
          LoginResponse loginResponse = LoginResponse.fromJson(data);

          // Store the entire JSON response
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('login_response', jsonEncode(data));

          LogService.info("Login Success: ${loginResponse.authToken}");
          return loginResponse;
        }
      }

      LogService.error("Login Failed: ${response.data}");
      return null;
    } catch (e) {
      LogService.error("Login Exception: $e");
      return null;
    }
  }
  */


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
