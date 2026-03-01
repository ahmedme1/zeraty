import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class CartController extends GetxController {
  final Rx<CartDataModel?> cartData = Rx<CartDataModel?>(null);
  final RxBool isLoading = false.obs;
  final RxList<PaymentMethodModel> paymentMethods = <PaymentMethodModel>[].obs;
  final Rx<PaymentMethodModel?> selectedPaymentMethod = Rx<PaymentMethodModel?>(null);
  final RxString couponCode = ''.obs;
  final RxBool isCouponApplied = false.obs;
  final RxBool isCouponLoading = false.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final notesController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCart();
    fetchPaymentMethods();
  }

  List<CartItemModel> get cartItems => cartData.value?.cartItems ?? [];
  double get total => cartData.value?.total ?? 0;
  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.cart,
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final cartResponse = CartResponse.fromJson(response.data);

        if (cartResponse.success) {
          cartData.value = cartResponse.data;
        }
      }
    } catch (e) {
      printLog('Error fetching cart: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.cart,
        data: {'product_id': productId, 'quantity': quantity},
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // CustomSnackbar.success('تم الإضافة للسلة');
        await fetchCart();
      } else {
        CustomSnackbar.error(response.statusCode.toString());
        CustomSnackbar.error(response.data.toString());
      }
    } catch (e) {
      printLog('Error adding to cart: $e');
      CustomSnackbar.error('فشل الإضافة للسلة');
    }
  }

  Future<void> removeCartItem(int cartItemId) async {
    try {
      final response = await DioHelper.deleteData(
        url: '${EndPoints.cart}/$cartItemId',
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        // CustomSnackbar.success('تم الحذف من السلة');
        await fetchCart();
      }
    } catch (e) {
      printLog('Error removing cart item: $e');
      CustomSnackbar.error('فشل الحذف من السلة');
    }
  }

  Future<void> clearCart() async {
    try {
      final response = await DioHelper.deleteData(
        url: EndPoints.cart,
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        CustomSnackbar.success('تم إفراغ السلة');
        await fetchCart();
      }
    } catch (e) {
      printLog('Error clearing cart: $e');
      CustomSnackbar.error('فشل إفراغ السلة');
    }
  }

  Future<void> fetchPaymentMethods() async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.paymentMethods,
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final paymentMethodsResponse = PaymentMethodsResponse.fromJson(response.data);

        if (paymentMethodsResponse.success) {
          paymentMethods.value = paymentMethodsResponse.data.where((pm) => pm.status).toList();
          if (paymentMethods.isNotEmpty) {
            selectedPaymentMethod.value = paymentMethods.first;
          }
        }
      }
    } catch (e) {
      printLog('Error fetching payment methods: $e');
    }
  }

  Future<void> redeemCoupon(String code) async {
    try {
      isCouponLoading.value = true;
      final response = await DioHelper.postData(
        url: EndPoints.redeemCoupon,
        data: {'code': code},
        sendAuthToken: true,
        showErrors: true,
      );
      final couponResponse = CouponResponse.fromJson(response.data);

      if (response.statusCode == 200) {
        if (couponResponse.success) {
          CustomSnackbar.success(couponResponse.message);
          couponCode.value = code;
          isCouponApplied.value = true;
          await fetchCart();
        }
      } else {
        if (!couponResponse.success) {
          CustomSnackbar.warning(couponResponse.message);
          // couponCode.value = code;
          isCouponApplied.value = false;
          // await fetchCart();
        }
      }
    } catch (e) {
      printLog('Error redeeming coupon: $e');
      CustomSnackbar.error('كوبون غير صالح');
      isCouponApplied.value = false;
    } finally {
      isCouponLoading.value = false;
    }
  }

  Future<void> createOrder({
    required String name,
    required String phone,
    required String address,
    required String state,
    String? notes,
  }) async {
    try {
      // if (selectedPaymentMethod.value == null) {
      //   CustomSnackbar.error('اختر وسيلة الدفع');
      //   return;
      // }

      isLoading.value = true;

      final response = await DioHelper.postData(
        url: EndPoints.orders,
        data: {
          'name': name,
          'phone': phone,
          'address': address,
          'state': state,
          // 'payment_method_id': selectedPaymentMethod.value!.id,
          if (isCouponApplied.value) 'coupon_code': couponCode.value,
          if (notes != null && notes.isNotEmpty) 'notes': notes,
        },
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomSnackbar.success('تم إنشاء الطلب بنجاح');
        await fetchCart();
        Get.offAll(() => HomeNavScreen(), transition: Transition.fade);
      }
    } catch (e) {
      printLog('Error creating order: $e');
      CustomSnackbar.error('فشل إنشاء الطلب');
    } finally {
      isLoading.value = false;
    }
  }

  void selectPaymentMethod(PaymentMethodModel method) {
    selectedPaymentMethod.value = method;
  }

  void increaseQuantity(int cartItemId, int currentQuantity) {
    final itemIndex = cartItems.indexWhere((item) => item.id == cartItemId);
    if (itemIndex != -1) {
      final item = cartItems[itemIndex];
      final newQuantity = currentQuantity + 1;
      final newSubtotal = item.product.finalPrice * newQuantity;

      cartItems[itemIndex] = CartItemModel(
        id: item.id,
        product: item.product,
        quantity: newQuantity,
        subtotal: newSubtotal,
      );

      cartData.value = CartDataModel(
        cartItems: cartItems,
        total: cartItems.fold(0, (sum, item) => sum + item.subtotal),
      );
    }

    updateCartItem(cartItemId, currentQuantity + 1);
  }

  void decreaseQuantity(int cartItemId, int currentQuantity) {
    if (currentQuantity > 1) {
      final itemIndex = cartItems.indexWhere((item) => item.id == cartItemId);
      if (itemIndex != -1) {
        final item = cartItems[itemIndex];
        final newQuantity = currentQuantity - 1;
        final newSubtotal = item.product.finalPrice * newQuantity;

        cartItems[itemIndex] = CartItemModel(
          id: item.id,
          product: item.product,
          quantity: newQuantity,
          subtotal: newSubtotal,
        );

        cartData.value = CartDataModel(
          cartItems: cartItems,
          total: cartItems.fold(0, (sum, item) => sum + item.subtotal),
        );
      }
      updateCartItem(cartItemId, currentQuantity - 1);
    }
  }

  Future<void> updateCartItem(int cartItemId, int quantity) async {
    try {
      await DioHelper.updateData(
        url: '${EndPoints.cart}/$cartItemId',
        data: {'quantity': quantity},
        sendAuthToken: true,
        showErrors: false,
        silent: true,
      );
    } catch (e) {
      printLog('Error updating cart item: $e');
      await fetchCart();
    }
  }
}
