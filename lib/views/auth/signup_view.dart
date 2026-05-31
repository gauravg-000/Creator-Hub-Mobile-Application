import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import '../../controllers/auth_controller.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController(); 
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) => (value == null || !value.contains('@')) ? 'Please enter a valid email' : null,
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
                  validator: (value) => (value == null || value.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool registrationSuccess = await authController.signUp(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        nameController.text.trim(),
                      );

                      if (registrationSuccess) {
                        nameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        Get.back();
                      }
                    }
                  },
                  child: const Text('Sign Up', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}