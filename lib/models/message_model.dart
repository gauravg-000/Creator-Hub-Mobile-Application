import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String text;
  final String senderId;
  final DateTime? timestamp;
  final List<String> readBy;

  MessageModel({required this.text, required this.senderId, this.timestamp, this.readBy = const []});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'] ?? '',
      senderId: json['senderId'] ?? '',
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
      readBy: List<String>.from(json['readBy'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'senderId': senderId,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
      'readBy': readBy,
    };
  }
}