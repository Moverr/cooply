import 'package:Cooply/providers/auth_provider.dart';
import 'package:Cooply/widgets/LoadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/AppConstants.dart';
import 'dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // late AuthProvider authProvider; // Global Instance

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'username',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Center(
                child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  handleLogin();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFFE3D9A8),

                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 20), // Adjust padding as needed

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),

                    // Removes border radius
                  ),
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Prevents excessive button width
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: AppConstants.fontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),

                    SizedBox(width: 8), // Space between icon and text
                    Icon(Icons.login), // Replace with your desired icon
                  ],
                ),
              ),
            )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Spaces items evenly
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centers items vertically
              children: [
                OutlinedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20), // Adjust padding as needed

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),

                      // Removes border radius
                    ),
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Prevents excessive button width
                    children: [
                      Image.asset(
                        "assets/google.png",
                        height: 24,
                        width: 24,
                      ),
                      // Replace with your desired icon
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20), // Adjust padding as needed

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),

                      // Removes border radius
                    ),
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Prevents excessive button width
                    children: [
                      Image.asset(
                        "assets/x.png",
                        height: 24,
                        width: 24,
                      ),
                      // Replace with your desired icon
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20), // Adjust padding as needed

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),

                      // Removes border radius
                    ),
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Prevents excessive button width
                    children: [
                      Image.asset(
                        "assets/facebook.png",
                        height: 24,
                        width: 24,
                      ),
                      // Replace with your desired icon
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  /// Login Action

  void handleLogin() async {
    //todo: commented out this line, to finish the UI
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      LoadingDialog.show(context, "Logging in ");

      /*
      // try {
      String username = _emailController.text;
      String password = _passwordController.text;
      AuthService authService = new AuthService();
      final loginResponse = await authService.loginUser(username, password);

      LoadingDialog.hide(context);

      if (loginResponse != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Failed"),
            backgroundColor: Colors.red,
          ),
        );
      }
      */

      try {
        String username = _emailController.text;
        String password = _passwordController.text;

        final authProvider = Provider.of<AuthProvider>(context, listen: false);

        await authProvider.login(username, password);

        if (authProvider.isLoggedIn == true) {
          //todo: go to dashboard
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Dashboard()));
        } else {
          // Simulate login action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login Failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An unexpected error occurred: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }

      //  LoadingDialog.hide(context);
    }
  }
}
