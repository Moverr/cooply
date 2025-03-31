import 'package:Cooply/services/AuthService.dart';
import 'package:flutter/foundation.dart';

import '../models/dtos/LoginResponse.dart';
import '../models/dtos/Role.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String _message;
  String _authToken;
  String _refreshToken;
  List<Role> _roles;
  String? _errorMessage;

  Future<void> login(String username, String password) async {
    try {
      LoginResponse? loginResponse =
          await _authService.login(username, password);
      if (loginResponse != null && loginResponse.isSuccessful) {
        //todo: tunawakalisha
        _isLoggedIn = true;
        _authToken = loginResponse.authToken;
        _message = loginResponse.message;
        _roles = loginResponse.roles;
        _errorMessage = null; // Clear any previous errors
      } else {
        _isLoggedIn = false;
        _authToken = "";
        _message = loginResponse?.message ??
            "Login failed"; // Use API message if available
        _roles = loginResponse?.roles ?? [];
        _errorMessage = "Invalid credentials"; // Set error message for UI
      }
    } catch (e) {
      _isLoggedIn = false;
      _errorMessage = "An error occurred: $e";
    } finally {
      notifyListeners(); // Update UI
    }
  }

  set authToken(String token) => _authToken = token;

  String get authToken => _authToken;

  String get message => _message;
  String get refreshToken => _refreshToken;

  List<Role> get roles => _roles;
}
