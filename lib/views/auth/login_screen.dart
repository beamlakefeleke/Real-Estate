import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/auth_view_model.dart';
import '../../core/theme.dart';
import '../../core/routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset('assets/images/logo.png', height: 100),

              const SizedBox(height: 20),
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
              ),
              const SizedBox(height: 10),
              const Text(
                "Login to your account",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Login Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty ? "Enter a valid email" : null,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) => value!.length < 6 ? "Password too short" : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {}, // Forgot password action
                  child: const Text("Forgot Password?", style: TextStyle(color: AppTheme.primaryColor)),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              authViewModel.isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: "Login",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authViewModel.loginUser(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (authViewModel.errorMessage == null) {
                            Navigator.pushReplacementNamed(context, AppRoutes.buyerHome);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(authViewModel.errorMessage!)),
                            );
                          }
                        }
                      },
                    ),

              const SizedBox(height: 20),

              // Google Sign-in Button
              OutlinedButton.icon(
                icon: Image.asset('assets/icons/google.png', height: 20),
                label: const Text("Sign in with Google"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {}, // Google login logic
              ),

              const SizedBox(height: 20),

              // Signup Redirect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                    child: const Text("Sign Up", style: TextStyle(color: AppTheme.primaryColor)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
