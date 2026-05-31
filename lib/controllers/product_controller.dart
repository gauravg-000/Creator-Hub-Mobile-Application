import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var products = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    listenToMarketplaceStorefront();
  }

  void listenToMarketplaceStorefront() {
    _firestore.collection('products').snapshots().listen((snapshot) {
      products.value = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
          .toList();
      isLoading.value = false;
    }, onError: (err) {
      Get.snackbar(
        'Market Error', 
        'Could not load current cart inventory.',
        backgroundColor: AppColors.like.withValues(alpha: 0.9),
      );
    });
  }

  Future<void> addNewProduct(String title, double price, String imageUrl) async {
    try {
      if (title.trim().isEmpty) {
        Get.snackbar(
          'Input Error', 
          'Please complete all required listing rows.',
          backgroundColor: AppColors.like.withValues(alpha: 0.5),
        );
        return;
      }

      String finalImageUrl = imageUrl.trim().isEmpty 
          ? 'https://images.unsplash.com/photo-1523275335684-37898b6baf30' 
          : imageUrl.trim();

      ProductModel product = ProductModel(
        id: '',
        title: title.trim(),
        price: price,
        imageUrl: finalImageUrl,
      );

      await _firestore.collection('products').add(product.toJson());
      Get.back();
      Get.snackbar(
        'Product Live', 
        'Inventory updated successfully.',
        backgroundColor: AppColors.price.withValues(alpha: 0.9),
      );
    } catch (e) {
      Get.snackbar(
        'Error', 
        'Failed to store new item.',
        backgroundColor: AppColors.like.withValues(alpha: 0.9),
      );
    }
  }

  void executeMockPurchase(String productTitle) {
    Get.snackbar(
      'Transaction Success',
      'Successfully purchased $productTitle! (Mock Gateway)',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.price.withValues(alpha: 0.9),
      duration: const Duration(seconds: 3),
    );
  }
}