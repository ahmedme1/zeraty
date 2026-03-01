import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class CartItemModel {
  final int id;
  final ProductModel product;
  final int quantity;
  final double subtotal;

  CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.subtotal,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? 0,
      product: ProductModel.fromJson(json['product'] ?? {}),
      quantity: json['quantity'] ?? 0,
      subtotal: (json['subtotal'] ?? 0).toDouble(),
    );
  }
}

class CartDataModel {
  final List<CartItemModel> cartItems;
  final double total;

  CartDataModel({required this.cartItems, required this.total});

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      cartItems:
          (json['cart_items'] as List?)?.map((e) => CartItemModel.fromJson(e)).toList() ?? [],
      total: (json['total'] ?? 0).toDouble(),
    );
  }
}

class CartResponse {
  final bool success;
  final String message;
  final CartDataModel data;

  CartResponse({required this.success, required this.message, required this.data});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CartDataModel.fromJson(json['data'] ?? {}),
    );
  }
}
