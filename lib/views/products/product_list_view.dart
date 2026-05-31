import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import '../../controllers/product_controller.dart';
import 'checkout_view.dart';

class ProductListView extends StatelessWidget {
  ProductListView({super.key});

  final ProductController productController = Get.put(ProductController());

  void _showAddProductDialog() {
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final imageController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('List New Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Item Name')),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price (INR)'), keyboardType: TextInputType.number),
            TextField(controller: imageController, decoration: const InputDecoration(labelText: 'Product Image Link (URL)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              double parsedPrice = double.tryParse(priceController.text) ?? 0.0;
              productController.addNewProduct(titleController.text, parsedPrice, imageController.text);
            },
            child: const Text('Launch Item'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        child: const Icon(Icons.add_business),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (productController.products.isEmpty) {
          return const Center(child: Text('Marketplace inventory is currently empty.'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final item = productController.products[index];

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        item.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(color: AppColors.textGrey, child: const Icon(Icons.image_not_supported)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Text('₹${item.price.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.price, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(visualDensity: VisualDensity.compact),
                            onPressed: () => Get.to(() => CheckoutView(product: item)),
                            child: const Text('Buy Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}