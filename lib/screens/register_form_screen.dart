import 'package:cooply/utils/AppConstants.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  bool _obscurePassword = true;

  void _register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registering User ...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 16),
              TextFormField(
                controller: _rePasswordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Re-enter Password',
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
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFFE3D9A8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                            fontFamily: AppConstants.fontFamily,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Spaces items evenly
                crossAxisAlignment: CrossAxisAlignment.center, // Centers items vertically
                children: [
                  OutlinedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(

                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Adjust padding as needed

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),

                        // Removes border radius
                      ),


                    ),
                    child:Row(
                      mainAxisSize: MainAxisSize.min, // Prevents excessive button width
                      children: [
                        Image.asset("assets/google.png",
                          height: 24,
                          width: 24,),
                        // Replace with your desired icon


                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(

                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Adjust padding as needed

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),

                        // Removes border radius
                      ),


                    ),
                    child:Row(
                      mainAxisSize: MainAxisSize.min, // Prevents excessive button width
                      children: [
                        Image.asset("assets/x.png",
                          height: 24,
                          width: 24,),
                        // Replace with your desired icon


                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(

                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Adjust padding as needed

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),

                        // Removes border radius
                      ),


                    ),
                    child:Row(
                      mainAxisSize: MainAxisSize.min, // Prevents excessive button width
                      children: [
                        Image.asset("assets/facebook.png",
                          height: 24,
                          width: 24,),
                        // Replace with your desired icon


                      ],
                    ),
                  ),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
