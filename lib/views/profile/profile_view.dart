import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import 'package:techworld_assignment/controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  void _showLogoutConfirmation(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textGrey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.like),
            onPressed: () {
              Navigator.pop(context);
              Get.find<AuthController>().signOut();
            },
            child: const Text('Logout', style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), centerTitle: true),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          String name = 'User';
          String email = 'No Email Added';

          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            name = data['name'] ?? 'User';
            email = data['email'] ?? 'No Email Added';
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      name[0].toUpperCase(),
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.like,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => _showLogoutConfirmation(context),
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text('Logout', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}