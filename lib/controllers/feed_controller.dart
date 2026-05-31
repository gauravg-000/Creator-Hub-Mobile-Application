import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import '../models/post_model.dart';

class FeedController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  var posts = <PostModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    listenToFeedStreams();
  }

  void listenToFeedStreams() {
    _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      posts.value = snapshot.docs
          .map((doc) => PostModel.fromJson(doc.data(), doc.id))
          .toList();
      isLoading.value = false;
    }, onError: (error) {
      Get.snackbar('Feed Error', 'Failed to update live social streams.',
      backgroundColor: AppColors.like.withValues(alpha: 0.9),);
    });
  }

  Future<void> createPost(String text, String? imageUrl) async {
    try {
      if (text.trim().isEmpty) return;

      String? currentUid = _auth.currentUser?.uid;
      String finalUserName = 'Active Creator';

      if (currentUid != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUid).get();
        if (userDoc.exists && userDoc.data() != null) {
          finalUserName = (userDoc.data() as Map<String, dynamic>)['name'] ?? 'Active Creator';
        }
      }
      
      PostModel newPost = PostModel(
        id: '',
        userName: finalUserName,
        text: text.trim(),
        imageUrl: imageUrl?.trim().isEmpty == true ? null : imageUrl?.trim(),
        likedBy: [],
      );

      await _firestore.collection('posts').add(newPost.toJson());
      Get.snackbar('Success', 'Post published successfully!',
      backgroundColor: AppColors.price.withValues(alpha: 0.9),);
    } catch (e) {
      Get.snackbar('Error', 'Could not broadcast post item.',
      backgroundColor: AppColors.like.withValues(alpha: 0.9),);
    }
  }

  Future<void> toggleLike(String postId, String currentUserId) async {
    try {
      DocumentReference postRef = _firestore.collection('posts').doc(postId);
      DocumentSnapshot snapshot = await postRef.get();
      
      if (!snapshot.exists) return;

      List<String> likedBy = List<String>.from(snapshot['likedBy'] ?? []);

      if (likedBy.contains(currentUserId)) {
        await postRef.update({
          'likedBy': FieldValue.arrayRemove([currentUserId])
        });
      } else {
        await postRef.update({
          'likedBy': FieldValue.arrayUnion([currentUserId])
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Action temporary unavailable.',
      backgroundColor: AppColors.like.withValues(alpha: 0.9),);
    }
  }
}