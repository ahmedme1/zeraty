class PaymentMethodModel {
  final int id;
  final String name;
  final String phoneNumber;
  final bool status;
  final String createdAt;
  final String updatedAt;

  PaymentMethodModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      status: json['status'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class PaymentMethodsResponse {
  final bool success;
  final String message;
  final List<PaymentMethodModel> data;

  PaymentMethodsResponse({required this.success, required this.message, required this.data});

  factory PaymentMethodsResponse.fromJson(Map<String, dynamic> json) {
    return PaymentMethodsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => PaymentMethodModel.fromJson(e)).toList() ?? [],
    );
  }
}
