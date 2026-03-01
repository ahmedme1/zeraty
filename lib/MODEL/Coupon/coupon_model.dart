class CouponResponse {
  final bool success;
  final String message;
  final dynamic data;

  CouponResponse({required this.success, required this.message, this.data});

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}
