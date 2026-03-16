import 'package:get/get.dart';

class PaymentHistoryModel {
  final String date;
  final String amount;
  final String method;
  final String category;
  final String processedBy;

  PaymentHistoryModel({
    required this.date,
    required this.amount,
    required this.method,
    required this.category,
    required this.processedBy,
  });
}

class PaymentController extends GetxController {
  // Summary Data
  final title = "Tuition Fee".obs;
  final status = "Active".obs;
  final payable = "48,500.00".obs;
  final paid = "140,000.00".obs;
  final due = "-91,500.00".obs;
  final dueDate = "19 Sep, 2025".obs;
  final note = "She will pay soon".obs;

  // History Data
  final paymentHistory = <PaymentHistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockHistory();
  }

  void _loadMockHistory() {
    paymentHistory.addAll([
      PaymentHistoryModel(
        date: "11 Sep, 2025",
        amount: "Rs. 20,000.00",
        method: "Cash",
        category: "Tuition Fee",
        processedBy: "Sanchita K.",
      ),
      PaymentHistoryModel(
        date: "15 Sep, 2025",
        amount: "Rs. 120,000.00",
        method: "eSewa",
        category: "Doc Processing",
        processedBy: "Sanchita K.",
      ),
    ]);
  }
}
