class UserModel {
  final int id;
  final String name;
  final String? email;
  final String role;
  final String? emailVerifiedAt;
  final String? city;
  final String? state;
  final String phone;
  final String? engineerCode;
  final String? address;
  final String? image;
  final String? imageUrl;
  final String? fcmToken;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    required this.role,
    this.emailVerifiedAt,
    this.city,
    this.state,
    required this.phone,
    this.engineerCode,
    this.address,
    this.image,
    this.imageUrl,
    this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'],
      role: json['role'] ?? 'user',
      emailVerifiedAt: json['email_verified_at'],
      city: json['city'],
      state: json['state'],
      phone: json['phone'] ?? '',
      engineerCode: json['engineer_code'],
      address: json['address'],
      image: json['image'],
      imageUrl: json['image_url'],
      fcmToken: json['fcm_token'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class UserResponse {
  final bool success;
  final String message;
  final UserModel data;

  UserResponse({required this.success, required this.message, required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: UserModel.fromJson(json['data'] ?? {}),
    );
  }
}
