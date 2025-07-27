import 'package:Cooply/services/AuthService.dart';
import 'package:flutter/foundation.dart';

import '../models/dtos/loginResponse.dart';
import '../models/dtos/message_response.dart';
import '../models/dtos/role.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  bool _isLoggedIn = false;
  bool _isUserACtive = false;

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


  Future<void> validateOTP(String otpCode) async {

    try {
      MessageResponse? response  = await _authService.validateToken(otpCode);

      if (response?.status == "declined") {
        _isregistered = false;
      } else {
        _isregistered = true;
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

      if (loginDataResponse != null ) {
        switch(loginDataResponse.status.toUpperCase()){
          case "ACTIVE":{
            _username = loginDataResponse.username;
            _isLoggedIn = true;
            _isUserACtive = true;
            _authToken = loginDataResponse.auth_token;
            _message = loginDataResponse.message ?? "Login successful";
            _roles = loginDataResponse.roles;
            _errorMessage = null; // Clear any previous errors

            logResponse = loginDataResponse;
          }
            break;
          case "PENDING":
            {
              _username = loginDataResponse.username;
              _isLoggedIn = true;
              _isUserACtive = false;
              _authToken = loginDataResponse.auth_token;
              _message = loginDataResponse.message ?? "Login Failed";
              _roles = loginDataResponse.roles;
              _errorMessage = null; // Clear any previous errors

              logResponse = loginDataResponse;

              _errorMessage = "User Is not Active "; // Shown in UI


            }
            break;
          default:
            {
              _username = loginDataResponse.username;
              _isLoggedIn = false;
              _isUserACtive = false;
              _authToken = null;
              _message =  null;
              _roles = null;
              _errorMessage = null; // Clear any previous errors

              logResponse = null;

              _errorMessage = "User Is not Active "; // Shown in UI


            }

            break;

        }

      } else {


        _isUserACtive = false;
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
  bool get isUserActive => _isUserACtive;


  bool get isRegistered => _isregistered;

  String? get username => _username;
}
