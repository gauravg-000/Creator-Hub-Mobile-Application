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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome Back', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(height: 8),
              const Text('Sign in to continue', style: TextStyle(color: AppColors.textGrey, fontSize: 15, height: 1.6)),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.border)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.border)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                        filled: true,
                        fillColor: AppColors.white,
                      ),
                      validator: (value) => (value == null || !value.contains('@')) ? 'Please enter a valid email' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.border)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.border)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                        filled: true,
                        fillColor: AppColors.white,
                      ),
                      obscureText: true,
                      validator: (value) => (value == null || value.length < 6) ? 'Password must be at least 6 characters' : null,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authController.login(emailController.text.trim(), passwordController.text.trim());
                          }
                        },
                        child: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New user? ', style: TextStyle(color: AppColors.textGrey, fontSize: 15)),
                  TextButton(
                    onPressed: () => Get.to(() => SignupView()),
                    child: const Text('Create Account', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15)),
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