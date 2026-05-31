import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import 'feed/feed_view.dart';
import 'chat/chat_list_view.dart';
import 'products/product_list_view.dart';
import 'profile/profile_view.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;
  
  final screens = [
    FeedView(),
    ChatListView(),
    ProductListView(),
    const ProfileView(),
  ];
}

class HomeNavigationView extends StatelessWidget {
  const HomeNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navKey = Get.put(NavigationController());

    return Scaffold(
      body: Obx(() => navKey.screens[navKey.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navKey.currentIndex.value,
          onTap: (index) => navKey.currentIndex.value = index,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textGrey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Products'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}