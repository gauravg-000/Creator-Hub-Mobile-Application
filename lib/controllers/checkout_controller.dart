import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import 'package:techworld_assignment/models/product_model.dart';
import 'package:techworld_assignment/views/products/payment_success_view.dart';

class CheckoutController extends GetxController {
  final ProductModel product;
  final paymentMethod = 'Credit Card'.obs;
  final isProcessing = false.obs;
  final customerName = TextEditingController();
  final customerEmail = TextEditingController();
  final shippingAddress = TextEditingController();

  CheckoutController({required this.product});

  double get shippingFee => 49.0;
  double get totalAmount => product.price + shippingFee;

  void selectPaymentMethod(String method) {
    paymentMethod.value = method;
  }

  Future<void> processPayment() async {
    if (customerName.text.trim().isEmpty || customerEmail.text.trim().isEmpty || shippingAddress.text.trim().isEmpty) {
      Get.snackbar('Checkout Error', 'Please complete all checkout fields.', snackPosition: SnackPosition.TOP, backgroundColor: AppColors.like);
      return;
    }
    isProcessing.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isProcessing.value = false;
    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    Get.to(() => PaymentSuccessView(
          product: product,
          paymentMethod: paymentMethod.value,
          customerName: customerName.text.trim(),
          orderId: orderId,
          totalPaid: totalAmount,
        ));
  }

  @override
  void onClose() {
    customerName.dispose();
    customerEmail.dispose();
    shippingAddress.dispose();
    super.onClose();
  }
}
