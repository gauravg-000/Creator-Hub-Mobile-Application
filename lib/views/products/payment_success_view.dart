import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import 'package:techworld_assignment/models/product_model.dart';
import 'package:techworld_assignment/views/home_navigation_view.dart';

class PaymentSuccessView extends StatelessWidget {
  final ProductModel product;
  final String paymentMethod;
  final String customerName;
  final String orderId;
  final double totalPaid;

  const PaymentSuccessView({
    super.key,
    required this.product,
    required this.paymentMethod,
    required this.customerName,
    required this.orderId,
    required this.totalPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Complete'), backgroundColor: AppColors.primary),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Container(
              height: 112,
              width: 112,
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.14), shape: BoxShape.circle),
              child: const Center(child: Icon(Icons.check_circle_outline, color: AppColors.primary, size: 64)),
            ),
            const SizedBox(height: 28),
            const Text('Order Confirmed', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('Thank you, $customerName', style: const TextStyle(fontSize: 16, color: AppColors.textGrey), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order id: $orderId', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Product: ${product.title}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Payment mode: $paymentMethod', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Amount paid: ₹${totalPaid.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, color: AppColors.price, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () => Get.offAll(() => const HomeNavigationView()),
                child: const Text('Back to Shop'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
