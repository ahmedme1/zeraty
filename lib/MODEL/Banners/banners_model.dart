import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class BannerModel {
  final int id;
  final String title;
  final String? description;
  final String? image;
  final String createdAt;

  BannerModel({
    required this.id,
    required this.title,
    this.description,
    this.image,
    required this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'],
      image: json['image'],
      createdAt: json['created_at'] ?? '',
    );
  }
}

class BannersResponse {
  final bool success;
  final String message;
  final List<BannerModel> data;
  final PaginationModel pagination;

  BannersResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory BannersResponse.fromJson(Map<String, dynamic> json) {
    return BannersResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => BannerModel.fromJson(e)).toList() ?? [],
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }
}
