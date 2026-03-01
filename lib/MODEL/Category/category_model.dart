class CategoriesResponse {
  final bool success;
  final String message;
  final List<CategoryModel> data;
  final PaginationModel pagination;

  CategoriesResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List?)?.map((e) => CategoryModel.fromJson(e)).toList() ?? [],
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }
}

class PaginationModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  PaginationModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 15,
      total: json['total'] ?? 0,
    );
  }
}

class CategoryModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final int productsCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.productsCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      productsCount: json['products_count'] ?? 0,
    );
  }
}
