import 'package:Cooply/providers/auth_provider.dart';
import 'package:Cooply/screens/verification_screen.dart';
import 'package:Cooply/utils/log_service.dart';
import 'package:Cooply/widgets/loadingDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/AppConstants.dart';
import '../widgets/Auth2RowWidget.dart';
import 'dashboard/dashboard_screen.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        body: Container(
      height: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
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
                  onFieldSubmitted: (value) {
                    handleLogin();
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                      // backgroundColor: Color(0XFFE3D9A8),

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
                        Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: AppConstants.defaultFont,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),

                        SizedBox(width: 8),
                        IconButton(
                          onPressed: null,
                          icon: FaIcon(FontAwesomeIcons.lock),
                          iconSize: 18,
                        ), // Replace with your desired icon
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                //todo: not yet implemented
                Auth2RowWidget() // handling Auth 2 buttons
              ],
            ),
          ),
        ),
      ),
    ));
  }

  /// Login Action

  Future<void> handleLogin() async {
    //todo: commented out this line, to finish the UI
    if (_formKey.currentState!.validate()) {
      try {
        FocusScope.of(context).unfocus();

        LoadingDialog.show(context, "Logging in ");

        String username = _emailController.text;
        String password = _passwordController.text;

        final authProvider = Provider.of<AuthProvider>(context, listen: false);

        await authProvider.login(username, password);

        LoadingDialog.hide(context);

        if (authProvider.isLoggedIn == true &&
            authProvider.isUserActive == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login Succesfully"),
              backgroundColor: Colors.green,
            ),
          );

          //todo: go to dashboard
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Dashboard()));
        } else if (authProvider.isLoggedIn == true &&
            authProvider.isUserActive == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Activate Your Account"),
              backgroundColor: Colors.green,
            ),
          );

          //todo: go to verification screen
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => VerificationScreen()));
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
        LoadingDialog.hide(context);

        print(e.toString());
        LogService.error(e.toString());

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
