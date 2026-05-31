import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import '../models/message_model.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var messages = <MessageModel>[].obs;
  var isLoading = true.obs;

  void listenToMessages(String chatId, String? currentUserId) {
    isLoading.value = true;
    _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      messages.value = snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      isLoading.value = false;
      if (currentUserId != null) {
        markMessagesRead(chatId, currentUserId);
      }
    }, onError: (error) {
      Get.snackbar('Chat Error', 'Failed to sync real-time conversation.',
      backgroundColor: AppColors.price.withValues(alpha: 0.9),);
    });
  }

  Future<void> markMessagesRead(String chatId, String currentUserId) async {
    try {
      final snapshot = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final senderId = data['senderId'] as String?;
        final readBy = List<String>.from(data['readBy'] ?? []);

        if (senderId != null && senderId != currentUserId && !readBy.contains(currentUserId)) {
          await doc.reference.update({
            'readBy': FieldValue.arrayUnion([currentUserId]),
          });
        }
      }
    } catch (e) {
      // ignore errors while marking read so chat still loads
    }
  }

  Future<void> sendMessage(String chatId, String text, String senderId) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'text': text,
        'senderId': senderId,
        'timestamp': FieldValue.serverTimestamp(),
        'readBy': [senderId],
      });
    } catch (e) {
      Get.snackbar('Error', 'Message could not be sent.',
      backgroundColor: AppColors.like);
    }
  }
}