import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class ProductDetailsController extends GetxController {
  final int productId;

  final Rx<ProductDetailsModel?> productDetails = Rx<ProductDetailsModel?>(null);
  final RxBool isLoading = false.obs;
  final RxInt quantity = 1.obs;
  final RxInt selectedShipping = 0.obs;

  ProductDetailsController({required this.productId});
  final isInCart = false.obs;

  void toggleCart() {
    final cartController = Get.find<CartController>();

    isInCart.value = !isInCart.value;

    if (!isInCart.value) {
      final cartItem = cartController.cartItems.firstWhereOrNull(
        (item) => item.product.id == productDetails.value!.id,
      );
      if (cartItem != null) {
        cartController.removeCartItem(cartItem.id).then((_) {
          if (cartController.cartItems.any((item) => item.product.id == productDetails.value!.id)) {
            isInCart.value = true;
          }
        });
      }
    } else {
      cartController.addToCart(productDetails.value!.id, quantity.value).then((_) {
        if (!cartController.cartItems.any((item) => item.product.id == productDetails.value!.id)) {
          isInCart.value = false;
        }
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.products(productId),
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final productDetailsResponse = ProductDetailsResponse.fromJson(response.data);

        if (productDetailsResponse.success) {
          productDetails.value = productDetailsResponse.data;
          isInCart.value = productDetails.value?.isInCart ?? false;
          quantity.value = 1;
          selectedShipping.value = 0;
        }
      }
    } catch (e) {
      printLog('Error fetching product details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void increaseQuantity() {
    if (productDetails.value != null && quantity.value < productDetails.value!.stock) {
      quantity.value++;
    }
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void selectShipping(int index) {
    selectedShipping.value = index;
  }

  double get totalPrice {
    if (productDetails.value != null) {
      return productDetails.value!.finalPrice * quantity.value;
    }
    return 0;
  }

  void addToCart() {
    if (productDetails.value != null) {
      final cartController = Get.find<CartController>();
      cartController.addToCart(productDetails.value!.id, quantity.value);
    }
  }
}
