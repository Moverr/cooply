import 'package:Cooply/services/AuthService.dart';
import 'package:flutter/foundation.dart';

import '../models/dtos/LoginResponse.dart';
import '../models/dtos/Role.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  bool _isLoggedIn = false;

  String? _username;
  String? _message;
  String? _authToken;
  String? _refreshToken;
  String? _errorMessage;

  List<Role>? _roles;

  bool _isregistered = false;

  Future<void> register(String username, String password) async {

    try {
      bool response  = await _authService.registerUser(username, password);

      if (response == true) {
        _isregistered = true;
      } else {
        _isregistered = false;
      }

    }
    catch(e) {

      _isregistered = false;
      _message = "An unexpected error occurred.";
      _errorMessage = "Error: $e"; // More useful for debugging/logging
      debugPrintStack();

    }
    finally{
      notifyListeners();
    }



  }

  LoginResponse? logResponse;

  Future<void> login(String username, String password) async {
    try {
      LoginResponse? loginDataResponse =
          await _authService.loginUser(username, password);

      if (loginDataResponse != null && loginDataResponse.isSuccessful) {
        _username = loginDataResponse.username;
        _isLoggedIn = true;
        _authToken = loginDataResponse.auth_token;
        _message = loginDataResponse.message ?? "Login successful";
        _roles = loginDataResponse.roles;
        _errorMessage = null; // Clear any previous errors

        logResponse = loginDataResponse;
        // TODO: Handle post-login actions (e.g., navigation, token storage)
      } else {
        _isLoggedIn = false;
        _authToken = "";
        _message = loginDataResponse?.message ?? "Login failed. Please try again.";
        _roles = loginDataResponse?.roles ?? [];
        _errorMessage = "Invalid credentials"; // Shown in UI
      }
    } catch (e) {
      logResponse = null;
      _isLoggedIn = false;
      _authToken = "";
      _roles = [];
      _message = "An unexpected error occurred.";
      _errorMessage = "Error: $e"; // More useful for debugging/logging
      debugPrintStack();
    } finally {
      notifyListeners(); // Update UI state
    }
  }


  void logout(){

    _isLoggedIn = false;
  }
  set authToken(String token) => _authToken = token;

  String? get message => _message;
  String? get refreshToken => _refreshToken;
  List<Role>? get roles => _roles;
  String? get loginAuthToken => _authToken;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;

  bool get isRegistered => _isregistered;

  String? get username => _username;
}
