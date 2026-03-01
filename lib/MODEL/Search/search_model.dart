import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class SearchProductModel {
  final int id;
  final String name;
  final String description;
  final String? image;
  final String price;
  final String discountPrice;
  final double finalPrice;
  final int stock;
  final bool isFavourite;
  final CategoryBasicModel category;
  final CompanyBasicModel company;
  final List<String> features;
  final List<String> specifications;

  SearchProductModel({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.price,
    required this.discountPrice,
    required this.finalPrice,
    required this.stock,
    required this.isFavourite,
    required this.category,
    required this.company,
    required this.features,
    required this.specifications,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      price: json['price'] ?? '0',
      discountPrice: json['discount_price'] ?? '0',
      finalPrice: (json['final_price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      isFavourite: json['is_favourite'] ?? false,
      category: CategoryBasicModel.fromJson(json['category'] ?? {}),
      company: CompanyBasicModel.fromJson(json['company'] ?? {}),
      features: (json['features'] as List?)?.map((e) => e.toString()).toList() ?? [],
      specifications: (json['specifications'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class CompanyBasicModel {
  final int id;
  final String name;

  CompanyBasicModel({required this.id, required this.name});

  factory CompanyBasicModel.fromJson(Map<String, dynamic> json) {
    return CompanyBasicModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
}

class SearchResponse {
  final bool success;
  final String message;
  final List<SearchProductModel> data;
  final PaginationModel pagination;

  SearchResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => SearchProductModel.fromJson(e)).toList() ?? [],
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }
}
