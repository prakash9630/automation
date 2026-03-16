import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CommentType { text, attachment, system }

class CommentModel {
  final String userName;
  final String userInitials;
  final Color avatarColor;
  final String timeAgo;
  final String content;
  final CommentType type;
  final String? fileName;
  final Map<String, String>? logData;

  CommentModel({
    required this.userName,
    required this.userInitials,
    required this.avatarColor,
    required this.timeAgo,
    required this.content,
    this.type = CommentType.text,
    this.fileName,
    this.logData,
  });
}

class CommentsController extends GetxController {
  final comments = <CommentModel>[].obs;
  final commentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadMockComments();
  }

  void _loadMockComments() {
    comments.addAll([
      CommentModel(
        userName: "Sanchita Kunwar",
        userInitials: "SK",
        avatarColor: const Color(0xFFE53935),
        timeAgo: "2 days ago",
        content: "She will pay soon",
        type: CommentType.attachment,
        fileName: "transcript.pdf",
      ),
      CommentModel(
        userName: "Narayan Nyaupane",
        userInitials: "NN",
        avatarColor: const Color(0xFF9C27B0),
        timeAgo: "6 months ago",
        content: "hello",
        type: CommentType.text,
      ),
      CommentModel(
        userName: "System",
        userInitials: "S",
        avatarColor: const Color(0xFF2196F3),
        timeAgo: "1 month ago",
        content: "Migration Log",
        type: CommentType.system,
        logData: {
          "Name": "Sapana Thapa",
          "Status": "Counseled",
          "Branch": "Main",
        },
      ),
    ]);
  }

  void sendComment() {
    if (commentController.text.trim().isNotEmpty) {
      comments.add(
        CommentModel(
          userName: "You",
          userInitials: "Y",
          avatarColor: Colors.grey,
          timeAgo: "Just now",
          content: commentController.text,
          type: CommentType.text,
        ),
      );
      commentController.clear();
    }
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}
