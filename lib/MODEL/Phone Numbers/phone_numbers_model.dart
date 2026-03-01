class PhoneNumberModel {
  final int id;
  final String phoneNumber;

  PhoneNumberModel({required this.id, required this.phoneNumber});

  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) {
    return PhoneNumberModel(id: json['id'] ?? 0, phoneNumber: json['phone_number'] ?? '');
  }
}

class PhoneNumbersResponse {
  final bool success;
  final String message;
  final List<PhoneNumberModel> data;

  PhoneNumbersResponse({required this.success, required this.message, required this.data});

  factory PhoneNumbersResponse.fromJson(Map<String, dynamic> json) {
    return PhoneNumbersResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => PhoneNumberModel.fromJson(e)).toList() ?? [],
    );
  }
}
