import 'package:Cooply/services/AuthService.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login() async {
    // Use AuthService from get_it
    _isLoggedIn = true;
    notifyListeners(); // Update UI
  }
}
