import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class OrderModel {
  final int id;
  final String name;
  final double totalAmount;
  final double discountAmount;
  final double finalAmount;
  final String status;
  final int itemsCount;
  final String createdAt;
  final bool isReceiptUploaded;

  OrderModel({
    required this.id,
    required this.name,
    required this.totalAmount,
    required this.discountAmount,
    required this.finalAmount,
    required this.status,
    required this.itemsCount,
    required this.createdAt,
    required this.isReceiptUploaded,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      finalAmount: (json['final_amount'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      itemsCount: json['items_count'] ?? 0,
      createdAt: json['created_at'] ?? '',
      isReceiptUploaded: json['is_receipt_uploaded'] ?? false,
    );
  }

  String get statusText {
    switch (status) {
      case 'pending':
        return 'قيد الانتظار';
      case 'processing':
        return 'قيد التنفيذ';
      case 'shipped':
        return 'تم الشحن';
      case 'delivered':
        return 'تم التوصيل';
      case 'cancelled':
        return 'ملغي';
      default:
        return status;
    }
  }

  Color get statusColor {
    switch (status) {
      case 'pending':
        return const Color(0xFFFF9800);
      case 'processing':
        return const Color(0xFF2196F3);
      case 'shipped':
        return const Color(0xFF9C27B0);
      case 'delivered':
        return const Color(0xFF4CAF50);
      case 'cancelled':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }
}

class OrdersResponse {
  final bool success;
  final String message;
  final List<OrderModel> data;
  final PaginationModel pagination;

  OrdersResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => OrderModel.fromJson(e)).toList() ?? [],
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }
}
