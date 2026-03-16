import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});
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
          'Payment',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            SizedBox(height: 24.h),
            Text(
              "PAYMENT HISTORY",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.paymentHistory.length,
                  itemBuilder: (context, index) {
                    final item = controller.paymentHistory[index];
                    return _buildHistoryItem(item);
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFEBF3F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                    controller.title.value,
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Obx(() => Text(
                      controller.status.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey[200]),
          SizedBox(height: 12.h),
          _buildSummaryRow("Payable", controller.payable.value, isBold: true),
          _buildSummaryRow("Paid", controller.paid.value, color: const Color(0xFF4CAF50)),
          _buildSummaryRow("Due", controller.due.value, color: const Color(0xFFE53935)),
          _buildSummaryRow("Due Date", controller.dueDate.value, isBold: true, labelColor: Colors.grey[500]),
          SizedBox(height: 12.h),
          Obx(() => Text(
                "Note: ${controller.note.value}",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                  fontStyle: FontStyle.italic,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color, bool isBold = false, Color? labelColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: labelColor ?? Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color ?? const Color(0xFF333333),
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(PaymentHistoryModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFEBF3F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.date,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
              ),
              Text(
                item.amount,
                style: TextStyle(
                  color: const Color(0xFF4CAF50),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E5B9C),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  item.method,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                item.category,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "By: ${item.processedBy}",
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
