import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class ProductController extends GetxController {
  final RxList<ProductModel> allProduct = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<CategoryDetailsModel?> categoryDetails = Rx<CategoryDetailsModel?>(null);

  Future<void> fetchCategoryProducts(int categoryId) async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.categoriesProduct(categoryId),
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final categoryDetailsResponse = CategoryDetailsResponse.fromJson(response.data);

        if (categoryDetailsResponse.success) {
          categoryDetails.value = categoryDetailsResponse.data;
          allProduct.value = categoryDetailsResponse.data.products;
        }
      }
    } catch (e) {
      printLog('Error fetching category products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFavorite(int index) async {
    final favoriteController = Get.find<FavoriteController>();
    final product = allProduct[index];
    await favoriteController.toggleFavorite(product.id);
    allProduct[index] = product.copyWith(isFavorite: !product.isFavorite);
    allProduct.refresh();
  }

  void addToCart(int index) {
    if (index < allProduct.length) {
      final cartController = Get.find<CartController>();
      cartController.addToCart(allProduct[index].id, 1);
    }
  }

  void toggleCart(int index) {
    if (index >= allProduct.length) return;

    final product = allProduct[index];
    final cartController = Get.find<CartController>();

    allProduct[index] = product.copyWith(isInCart: !product.isInCart);
    update();

    if (product.isInCart) {
      final cartItem = cartController.cartItems.firstWhereOrNull(
        (item) => item.product.id == product.id,
      );
      if (cartItem != null) {
        cartController.removeCartItem(cartItem.id).then((_) {
          if (cartController.cartItems.any((item) => item.product.id == product.id)) {
            allProduct[index] = product.copyWith(isInCart: true);
            update();
          }
        });
      }
    } else {
      cartController.addToCart(product.id, 1).then((_) {
        if (!cartController.cartItems.any((item) => item.product.id == product.id)) {
          allProduct[index] = product.copyWith(isInCart: false);
          update();
        }
      });
    }
  }

  void syncCartState() {
    final cartController = Get.find<CartController>();
    for (int i = 0; i < allProduct.length; i++) {
      final isInCart = cartController.cartItems.any((item) => item.product.id == allProduct[i].id);
      if (allProduct[i].isInCart != isInCart) {
        allProduct[i] = allProduct[i].copyWith(isInCart: isInCart);
      }
    }
    allProduct.refresh();
  }
}
