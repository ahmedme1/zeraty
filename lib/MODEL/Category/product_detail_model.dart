class CategoryBasicModel {
  final int id;
  final String name;

  CategoryBasicModel({required this.id, required this.name});

  factory CategoryBasicModel.fromJson(Map<String, dynamic> json) {
    return CategoryBasicModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
}

class ProductDetailsModel {
  final int id;
  final String name;
  final String description;
  final String? image;
  final String price;
  final String discountPrice;
  final double finalPrice;
  final bool isFavorite;
  final bool isInCart;
  final int stock;
  final CategoryBasicModel category;
  final List<String> features;
  final List<String> specifications;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.price,
    required this.discountPrice,
    required this.finalPrice,
    required this.stock,
    required this.category,
    required this.features,
    required this.specifications,
    this.isFavorite = false,
    this.isInCart = false,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      price: json['price'] ?? '0',
      discountPrice: json['discount_price'] ?? '0',
      finalPrice: (json['final_price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      category: CategoryBasicModel.fromJson(json['category'] ?? {}),
      features: (json['features'] as List?)?.map((e) => e.toString()).toList() ?? [],
      specifications: (json['specifications'] as List?)?.map((e) => e.toString()).toList() ?? [],
      isFavorite: json['is_favourite'] ?? false,
      isInCart: json['is_in_cart'] ?? false,
    );
  }
}

class ProductDetailsResponse {
  final bool success;
  final String message;
  final ProductDetailsModel data;

  ProductDetailsResponse({required this.success, required this.message, required this.data});

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ProductDetailsModel.fromJson(json['data'] ?? {}),
    );
  }
}
