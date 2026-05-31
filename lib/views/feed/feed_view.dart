import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import '../../controllers/feed_controller.dart';

class FeedView extends StatelessWidget {
  FeedView({super.key});
  final FeedController feedController = Get.put(FeedController());

  void _showCreatePostDialog(BuildContext context) {
    final textController = TextEditingController();
    final imageController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Create Community Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "What is on your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                hintText: "This is Optional Network Image URL",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (textController.text.trim().isNotEmpty) {
              feedController.createPost(
                textController.text,
                imageController.text,
              );
              Navigator.pop(context);
            } else {
              Get.snackbar('Required', 'Post text cannot be empty');
            }
          },
          child: const Text('Post'),
        ),
      ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Posts'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostDialog(context),
        child: const Icon(Icons.add_comment),
      ),
      body: Obx(() {
        if (feedController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (feedController.posts.isEmpty) {
          return const Center(child: Text('No updates available in feed yet.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: feedController.posts.length,
          itemBuilder: (context, index) {
            final post = feedController.posts[index];
            final hasLiked = post.likedBy.contains(currentUserId);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
                    const SizedBox(height: 6),
                    Text(post.text, style: const TextStyle(fontSize: 14, color: AppColors.textDark)),
                    if (post.imageUrl != null) ...[
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          post.imageUrl!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => const SizedBox.shrink(),
                        ),
                      ),
                    ],
                    const Divider(height: 24),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            hasLiked ? Icons.favorite : Icons.favorite_border,
                            color: hasLiked ? AppColors.like : AppColors.textGrey,
                          ),
                          onPressed: () => feedController.toggleLike(post.id, currentUserId),
                        ),
                        Text('${post.likedBy.length} Likes', style: TextStyle(color: AppColors.textGrey)),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}