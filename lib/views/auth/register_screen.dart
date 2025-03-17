import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import '../../view_models/auth_view_model.dart';
import '../../core/theme.dart';
import '../../core/routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_field.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedRole = "buyer";

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // App Logo
              Image.asset('assets/images/logo.png', height: 100),

              const SizedBox(height: 20),
              const Text("Create an Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),

              const SizedBox(height: 30),

              // Register Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(controller: _nameController, hintText: "Full Name", icon: Icons.person, validator: (value) => value!.isEmpty ? "Enter your name" : null),
                    const SizedBox(height: 15),
                    CustomTextField(controller: _emailController, hintText: "Email", icon: Icons.email, keyboardType: TextInputType.emailAddress, validator: (value) => value!.isEmpty ? "Enter a valid email" : null),
                    const SizedBox(height: 15),
                    CustomTextField(controller: _phoneController, hintText: "Phone Number", icon: Icons.phone, keyboardType: TextInputType.phone, validator: (value) => value!.isEmpty ? "Enter a valid phone number" : null),
                    const SizedBox(height: 15),
                    CustomTextField(controller: _passwordController, hintText: "Password", icon: Icons.lock, obscureText: true, validator: (value) => value!.length < 6 ? "Password too short" : null),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Role Selection
              DropdownButton<String>(
                value: _selectedRole,
                onChanged: (value) => setState(() => _selectedRole = value!),
                items: ["buyer", "seller", "admin"].map((role) => DropdownMenuItem(value: role, child: Text(role.capitalize()))).toList(),
              ),

              const SizedBox(height: 20),

              // Register Button
              authViewModel.isLoading ? const CircularProgressIndicator() : CustomButton(
                text: "Register",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await authViewModel.registerUser(
                      _nameController.text, _emailController.text, _passwordController.text, _phoneController.text, _selectedRole,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
