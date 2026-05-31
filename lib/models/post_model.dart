import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String userName;
  final String text;
  final String? imageUrl;
  final List<String> likedBy;
  final DateTime? timestamp;

  PostModel({
    required this.id,
    required this.userName,
    required this.text,
    this.imageUrl,
    required this.likedBy,
    this.timestamp,
  });

  factory PostModel.fromJson(Map<String, dynamic> json, String documentId) {
    return PostModel(
      id: documentId,
      userName: json['userName'] ?? 'Anonymous Creator',
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'],
      likedBy: List<String>.from(json['likedBy'] ?? []),
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'text': text,
      'imageUrl': imageUrl,
      'likedBy': likedBy,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }
}