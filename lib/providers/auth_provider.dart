import 'package:Cooply/services/AuthService.dart';
import 'package:flutter/foundation.dart';

import '../models/dtos/LoginResponse.dart';
import '../models/dtos/Role.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String ? _message;
  String ? _authToken;
  String ? _refreshToken;
  String? _errorMessage;

  List<Role> ?  _roles;



  void  login(String username, String password) async {

    /*
    try {
      LoginResponse? loginResponse = await _authService.login(username, password);

      if (loginResponse != null && loginResponse.isSuccessful) {
        _isLoggedIn = true;
        _authToken = loginResponse.authToken;
        _message = loginResponse.message ?? "Login successful";
        _roles = loginResponse.roles;
        _errorMessage = null; // Clear any previous errors

        // TODO: Handle post-login actions (e.g., navigation, token storage)
      } else {
        _isLoggedIn = false;
        _authToken = "";
        _message = loginResponse?.message ?? "Login failed. Please try again.";
        _roles = loginResponse?.roles ?? [];
        _errorMessage = "Invalid credentials"; // Shown in UI
      }
    } catch (e) {
      _isLoggedIn = false;
      _authToken = "";
      _roles = [];
      _message = "An unexpected error occurred.";
      _errorMessage = "Error: $e"; // More useful for debugging/logging
    } finally {
      notifyListeners(); // Update UI state
    }

    */
    notifyListeners();

  }



  set authToken(String token) => _authToken = token;


  String? get message => _message;
  String? get refreshToken => _refreshToken;
  List<Role>? get roles => _roles;
  String ? get loginAuthToken => _authToken;
  String ? get errorMessage => _errorMessage;

}
