import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class CompanyModel {
  final int id;
  final String name;
  final String description;
  final String? logo;
  final int productsCount;

  CompanyModel({
    required this.id,
    required this.name,
    required this.description,
    this.logo,
    required this.productsCount,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'],
      productsCount: json['products_count'] ?? 0,
    );
  }
}

class CompaniesResponse {
  final bool success;
  final String message;
  final List<CompanyModel> data;
  final PaginationModel pagination;

  CompaniesResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory CompaniesResponse.fromJson(Map<String, dynamic> json) {
    return CompaniesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => CompanyModel.fromJson(e)).toList() ?? [],
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }
}

class CompanyDetailsModel {
  final int id;
  final String name;
  final String description;
  final String? logo;
  final List<ProductModel> products;

  CompanyDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    this.logo,
    required this.products,
  });

  factory CompanyDetailsModel.fromJson(Map<String, dynamic> json) {
    return CompanyDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'],
      products: (json['products'] as List?)?.map((e) => ProductModel.fromJson(e)).toList() ?? [],
    );
  }
}

class CompanyDetailsResponse {
  final bool success;
  final String message;
  final CompanyDetailsModel data;

  CompanyDetailsResponse({required this.success, required this.message, required this.data});

  factory CompanyDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CompanyDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CompanyDetailsModel.fromJson(json['data'] ?? {}),
    );
  }
}
