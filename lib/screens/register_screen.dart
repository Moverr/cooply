import 'package:Cooply/screens/verification_screen.dart';
import 'package:Cooply/services/auth_service.dart';
import 'package:Cooply/widgets/Auth2RowWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/AppConstants.dart';
import '../widgets/loadingDialog.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  bool _obscurePassword = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      labelText: 'Email',
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _rePasswordController,
                    obscureText: _obscurePassword,
                    onFieldSubmitted: (value) {
                      handleUserRegistration();
                    },
                    decoration: InputDecoration(
                      labelText: 'Re-enter Password',
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
                        return 'Please re-enter your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed:(){
                          handleUserRegistration();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppConstants.DashboardSideVIewDefault,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                fontFamily: AppConstants.defaultFont,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.login),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Auth2RowWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


 void  handleUserRegistration() async {

    //todo: we are gona use auth provider still to register  and move
    if (_formKey.currentState!.validate()) {

      try {
        LoadingDialog.show(context, "Registering User ...  ");

        String username = _emailController.text;
        String password = _passwordController.text;



        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.register(username, password);


        if (authProvider.isRegistered == true) {

          DefaultTabController.of(context).animateTo(0);
          //todo: rotate to the first tab
          LoadingDialog.hide(context);


          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User Registration successful"),
              backgroundColor: Colors.green,
            ),
          );


          //todo: go to verification screen
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => VerificationScreen()));

        } else {
          LoadingDialog.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User Registration failed"),
              backgroundColor: Colors.red,
            ),
          );
        }


      }
      catch(e){
        print(e.toString());
        LoadingDialog.hide(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong"),
            backgroundColor: Colors.red,
          ),
        );
    }


    }
  }


}
