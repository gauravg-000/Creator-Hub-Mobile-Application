import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import 'package:techworld_assignment/controllers/auth_controller.dart';
import 'chat_room_view.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final currentUserId = authController.user.value?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Direct Messages'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collectionGroup('messages').snapshots(),
        builder: (context, messageSnapshot) {
          final unreadCounts = <String, int>{};
          if (messageSnapshot.hasData && currentUserId != null) {
            for (var doc in messageSnapshot.data!.docs) {
              final data = doc.data() as Map<String, dynamic>;
              final senderId = data['senderId'] as String?;
              final readBy = List<String>.from(data['readBy'] ?? []);
              final chatId = doc.reference.parent.parent?.id;
              if (senderId != null && senderId != currentUserId && chatId != null && chatId.split('_').contains(currentUserId) && !readBy.contains(currentUserId)) {
                unreadCounts[chatId] = (unreadCounts[chatId] ?? 0) + 1;
              }
            }
          }

          final unreadChatCount = unreadCounts.length;

          return Column(
            children: [
              if (unreadChatCount > 0)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 6),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('New messages', style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          unreadChatCount.toString(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No active users found.'));
                    }

                    final users = snapshot.data!.docs;
                    final filteredUsers = users.where((doc) => doc.id != currentUserId).toList();

                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final userData = filteredUsers[index].data() as Map<String, dynamic>;
                        final userId = filteredUsers[index].id;
                        final userName = userData['name'] ?? 'User';

                        final ids = [currentUserId!, userId];
                        ids.sort();
                        final combinedChatId = ids.join("_");
                        final userUnreadCount = unreadCounts[combinedChatId] ?? 0;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.primary,
                              child: Text(userName[0].toUpperCase()),
                            ),
                            title: Text(userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(userData['phone'] ?? userData['email'] ?? ''),
                            trailing: userUnreadCount > 0
                                ? Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Text(
                                      userUnreadCount.toString(),
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : const Icon(Icons.chat, color: AppColors.primary),
                            onTap: () {
                              Get.to(() => ChatRoomView(chatId: combinedChatId, receiverName: userName));
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}