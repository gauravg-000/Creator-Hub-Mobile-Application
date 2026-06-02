import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import 'package:techworld_assignment/controllers/checkout_controller.dart';
import 'package:techworld_assignment/models/product_model.dart';

class CheckoutView extends StatelessWidget {
  final ProductModel product;

  const CheckoutView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.put(CheckoutController(product: product), tag: product.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(product.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        Text('₹${product.price.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.price, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('Delivery in 2-3 business days', style: TextStyle(color: AppColors.textGrey)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Shipping fee', style: TextStyle(color: AppColors.textGrey)),
                        Text('₹${controller.shippingFee.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.price)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total payable', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('₹${controller.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.price)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Shipping Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: controller.customerName,
              decoration: const InputDecoration(labelText: 'Full name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.customerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email address', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.shippingAddress,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Shipping address', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            const Text('Payment Method', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Obx(
              () => Row(
                children: [
                  _paymentOption(controller, 'Credit Card'),
                  const SizedBox(width: 12),
                  _paymentOption(controller, 'UPI'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: controller.isProcessing.value ? null : controller.processPayment,
                  child: controller.isProcessing.value
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                            SizedBox(width: 12),
                            Text('Completing payment...'),
                          ],
                        )
                      : Text('Pay ₹${controller.totalAmount.toStringAsFixed(2)}',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _paymentOption(CheckoutController controller, String label) {
    final isSelected = controller.paymentMethod.value == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectPaymentMethod(label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: isSelected ? AppColors.primary : Colors.white,
            border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade300),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: isSelected ? Colors.white : AppColors.textDark, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
