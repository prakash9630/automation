import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/comments_controller.dart';

class CommentsView extends GetView<CommentsController> {
  const CommentsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1E5B9C)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Comments',
          style: TextStyle(
            color: const Color(0xFF333333),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Divider(height: 1.h, thickness: 1.h, color: Colors.grey[200]),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.all(16.r),
                  itemCount: controller.comments.length,
                  itemBuilder: (context, index) {
                    final comment = controller.comments[index];
                    return _buildCommentItem(comment);
                  },
                )),
          ),
          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildCommentItem(CommentModel comment) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: comment.avatarColor,
            child: Text(
              comment.userInitials,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.userName,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  comment.timeAgo,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                if (comment.type == CommentType.system)
                  _buildSystemCard(comment)
                else
                  _buildCommentBubble(comment),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentBubble(CommentModel comment) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3F9),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12.r),
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.content,
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: 14.sp,
            ),
          ),
          if (comment.type == CommentType.attachment) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.attach_file, size: 16.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  comment.fileName!,
                  style: TextStyle(
                    color: const Color(0xFF1E5B9C),
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSystemCard(CommentModel comment) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF9E7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Migration Log",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          ...comment.logData!.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    entry.value,
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7F9),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: controller.commentController,
                  decoration: InputDecoration(
                    hintText: "Write a comment... @mention",
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: controller.sendComment,
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: const Color(0xFF1E5B9C),
                child: Icon(Icons.send, color: Colors.white, size: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
