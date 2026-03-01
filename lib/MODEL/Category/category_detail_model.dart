class CategoryDetailsResponse {
  final bool success;
  final String message;
  final CategoryDetailsModel data;

  CategoryDetailsResponse({required this.success, required this.message, required this.data});

  factory CategoryDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CategoryDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CategoryDetailsModel.fromJson(json['data'] ?? {}),
    );
  }
}

class CategoryDetailsModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final List<ProductModel> products;

  CategoryDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.products,
  });

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    return CategoryDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      products: (json['products'] as List?)?.map((e) => ProductModel.fromJson(e)).toList() ?? [],
    );
  }
}

class ProductModel {
  final int id;
  final String name;
  final String description;
  final bool isFavorite;
  final bool isInCart;
  final String? image;
  final String price;
  final String discountPrice;
  final double finalPrice;
  final int stock;
  final bool? inStock;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.price,
    required this.discountPrice,
    required this.finalPrice,
    required this.stock,
    this.inStock,
    this.isFavorite = false,
    this.isInCart = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      price: json['price'] ?? '0',
      discountPrice: json['discount_price'] ?? '0',
      finalPrice: (json['final_price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      inStock: json['in_stock'],
      isFavorite: json['is_favourite'] ?? false,
      isInCart: json['is_in_cart'] ?? false,
    );
  }
  ProductModel copyWith({bool? isFavorite, bool? isInCart}) {
    return ProductModel(
      id: id,
      name: name,
      description: description,
      image: image,
      price: price,
      discountPrice: discountPrice,
      finalPrice: finalPrice,
      stock: stock,
      inStock: inStock,
      isFavorite: isFavorite ?? this.isFavorite,
      isInCart: isInCart ?? this.isInCart,
    );
  }
}
