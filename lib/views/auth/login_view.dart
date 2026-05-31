import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import '../../controllers/auth_controller.dart';
import 'signup_view.dart'; 

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters'; 
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  }
                },
                child: const Text('Login', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.to(() => SignupView()), 
                child: const Text(
                  "New User? Register Now",
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}