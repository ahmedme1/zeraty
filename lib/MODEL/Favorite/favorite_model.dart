import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class WishlistItemModel {
  final int id;
  final ProductModel product;
  final String addedAt;

  WishlistItemModel({required this.id, required this.product, required this.addedAt});

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['id'] ?? 0,
      product: ProductModel.fromJson(json['product'] ?? {}),
      addedAt: json['added_at'] ?? '',
    );
  }
}

class WishlistResponse {
  final bool success;
  final String message;
  final List<WishlistItemModel> data;
  final PaginationModel pagination;

  WishlistResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => WishlistItemModel.fromJson(e)).toList() ?? [],
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }
}
