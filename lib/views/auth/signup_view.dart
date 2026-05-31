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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create Account', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(height: 8),
              const Text('Join our community today', style: TextStyle(color: AppColors.textGrey, fontSize: 15, height: 1.6)),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: const Icon(Icons.person_outline, color: AppColors.primary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.border)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.border)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                        filled: true,
                        fillColor: AppColors.white,
                      ),
                      validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 16),
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
                        child: const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have account? ', style: TextStyle(color: AppColors.textGrey, fontSize: 15)),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Login', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15)),
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