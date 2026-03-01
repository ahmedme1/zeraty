class AddressModel {
  final int id;
  final String title;
  final String address;
  final String city;

  AddressModel({required this.id, required this.title, required this.address, required this.city});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
    );
  }
}

class AddressesResponse {
  final bool success;
  final String message;
  final List<AddressModel> data;

  AddressesResponse({required this.success, required this.message, required this.data});

  factory AddressesResponse.fromJson(Map<String, dynamic> json) {
    return AddressesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => AddressModel.fromJson(e)).toList() ?? [],
    );
  }
}
