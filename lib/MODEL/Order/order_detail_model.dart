import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class OrderItemModel {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double price;
  final String createdAt;
  final String updatedAt;
  final ProductDetailsInOrder product;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      product: ProductDetailsInOrder.fromJson(json['product'] ?? {}),
    );
  }

  double get subtotal => price * quantity;
}

class ProductDetailsInOrder {
  final int id;
  final String name;
  final String description;
  final String? image;
  final String price;
  final String discountPrice;
  final int stock;
  final bool status;

  ProductDetailsInOrder({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.price,
    required this.discountPrice,
    required this.stock,
    required this.status,
  });

  factory ProductDetailsInOrder.fromJson(Map<String, dynamic> json) {
    return ProductDetailsInOrder(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      price: json['price'] ?? '0',
      discountPrice: json['discount_price'] ?? '0',
      stock: json['stock'] ?? 0,
      status: json['status'] ?? false,
    );
  }
}

class OrderDetailsModel {
  final int id;
  final int userId;
  final String name;
  final int? couponId;
  final int paymentMethodId;
  final String status;
  final double totalAmount;
  final double discountAmount;
  final double finalAmount;
  final String phone;
  final String address;
  final String state;
  final String? notes;
  final String createdAt;
  final String updatedAt;
  final List<OrderItemModel> items;
  final dynamic coupon;
  final bool isReceiptUploaded;

  OrderDetailsModel({
    required this.id,
    required this.userId,
    required this.name,
    this.couponId,
    required this.paymentMethodId,
    required this.status,
    required this.totalAmount,
    required this.discountAmount,
    required this.finalAmount,
    required this.phone,
    required this.address,
    required this.state,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    this.coupon,
    required this.isReceiptUploaded,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      couponId: json['coupon_id'],
      paymentMethodId: json['payment_method_id'] ?? 0,
      status: json['status'] ?? 'pending',
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      finalAmount: (json['final_amount'] ?? 0).toDouble(),
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      notes: json['notes'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      items: (json['items'] as List?)?.map((e) => OrderItemModel.fromJson(e)).toList() ?? [],
      coupon: json['coupon'],
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

class OrderDetailsResponse {
  final bool success;
  final String message;
  final OrderDetailsModel data;

  OrderDetailsResponse({required this.success, required this.message, required this.data});

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: OrderDetailsModel.fromJson(json['data'] ?? {}),
    );
  }
}
