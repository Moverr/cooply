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




  Future<void> login(String username, String password) async {

    LoginResponse? loginResponse  = await _authService.login(username, password);
    if(loginResponse != null && loginResponse.isSuccessful ){

      //todo: tunawakalisha
    }





    /*  if(resp != null && resp.isSuccessful){
        setAuthToken(true);
        _authToken = resp.authToken;
        _message = resp.message;
        _roles = resp.roles;
      }*/
     /* else
      {

        _isLoggedIn = false;

        this.authToken = resp.authToken;
    this.message = resp.message;
    this.roles = resp.roles;

    }
      */



 
 


    // Use AuthService from get_it

    _isLoggedIn = true;
    notifyListeners(); // Update UI
  }


set authToken(String token) => _authToken = token;

  String get authToken  => _authToken;

  String get message  => _message;
  String get refreshToken  => _refreshToken;

  List<Role> get roles  => _roles;



}
