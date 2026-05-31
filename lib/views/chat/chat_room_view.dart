import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techworld_assignment/constants/app_colors.dart';
import 'package:techworld_assignment/controllers/auth_controller.dart';
import 'package:techworld_assignment/controllers/chat_controller.dart';

class ChatRoomView extends StatelessWidget {
  final String chatId;
  final String receiverName;
  ChatRoomView({super.key, required this.chatId, required this.receiverName});

  final ChatController chatController = Get.put(ChatController());
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUserId = authController.user.value?.uid;
    chatController.listenToMessages(chatId, currentUserId);

    return Scaffold(
      appBar: AppBar(
        title: Text(receiverName),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (chatController.messages.isEmpty) {
                return const Center(
                  child: Text(
                    'No messages. Start Chatting 👋',
                    style: TextStyle(color: AppColors.textGrey, fontSize: 16),
                  ),
                ); 
              }

              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final msg = chatController.messages[index];
                  final isMe = msg.senderId == authController.user.value?.uid;
                  
                  String timeString = "Sending...";
                  if (msg.timestamp != null) {
                    final hour = msg.timestamp!.hour.toString().padLeft(2, '0');
                    final minute = msg.timestamp!.minute.toString().padLeft(2, '0');
                    timeString = "$hour:$minute";
                  }
                  
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: isMe ? AppColors.primary : AppColors.textGrey,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
                              bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(
                              color: isMe ? AppColors.white : AppColors.textDark,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
                          child: Text(
                            timeString,
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.textGrey.withValues(alpha:0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.textGrey,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 22,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: AppColors.white, size: 20),
                    onPressed: () {
                      if (messageController.text.trim().isNotEmpty) {
                        chatController.sendMessage(
                          chatId, 
                          messageController.text.trim(), 
                          authController.user.value!.uid
                        );
                        messageController.clear();
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}