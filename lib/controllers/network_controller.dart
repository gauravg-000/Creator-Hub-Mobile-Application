import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:techworld_assignment/constants/app_colors.dart';

class NetworkController extends GetxController {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }
  Future<void> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected.value = true;
      }
    } on SocketException catch (_) {
      isConnected.value = false;
      Get.snackbar(
        'Offline Protocol Engaged',
        'Hardware network (Socket Issue) detected.\nPlease check your connection.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.like.withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 6),
      );
    }
  }
}