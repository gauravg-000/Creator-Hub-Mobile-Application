import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/auth_controller.dart';
import 'controllers/network_controller.dart';
import 'views/home_navigation_view.dart';
import 'views/auth/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(NetworkController());
  Get.put(AuthController());
  
  runApp(const CreatorHubApp());
}

class CreatorHubApp extends StatelessWidget {
  const CreatorHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Creator Hub Mobile Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const InitializerWidget(),
    );
  }
}

class InitializerWidget extends GetWidget<AuthController> {
  const InitializerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isInitialCheckDone.value) {
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  'Checking session...',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        );
      }
      if (controller.user.value != null) {
        return const HomeNavigationView();
      } else {
        return LoginView();
      }
    });
  }
}