class TechnicalSupportModel {
  final int id;
  final String name;
  final String phone;

  TechnicalSupportModel({required this.id, required this.name, required this.phone});

  factory TechnicalSupportModel.fromJson(Map<String, dynamic> json) {
    return TechnicalSupportModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class TechnicalSupportResponse {
  final bool success;
  final String message;
  final List<TechnicalSupportModel> data;

  TechnicalSupportResponse({required this.success, required this.message, required this.data});

  factory TechnicalSupportResponse.fromJson(Map<String, dynamic> json) {
    return TechnicalSupportResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => TechnicalSupportModel.fromJson(e)).toList() ?? [],
    );
  }
}
