import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: ColorsApp.backgroundColor,
            appBar: CustomAppBar(
              title: 'السلة',
              actions: [
                Obx(() {
                  if (controller.cartItems.isEmpty) return const SizedBox.shrink();
                  return IconButton(
                    onPressed: () => _showClearCartDialog(context, controller),
                    icon: Icon(Icons.delete_outline, color: Colors.red, size: 24.sp),
                  );
                }),
              ],
            ),
            body: CheckLogin(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.cartItems.isEmpty) {
                  return _buildEmptyCart();
                }

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 16.h),
                            _buildCartItems(controller),
                            SizedBox(height: 16.h),
                            _buildCouponSection(controller),
                            SizedBox(height: 16.h),
                            _buildSummaryCard(controller),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            bottomNavigationBar: Obx(() {
              if (controller.cartItems.isEmpty) return const SizedBox.shrink();
              return _buildCheckoutButton(controller);
            }),
          ),
        );
      },
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 60.sp,
              color: ColorsApp.primaryGreenColor,
            ),
          ),
          SizedBox(height: 24.h),
          text(
            title: 'السلة فارغة',
            color: ColorsApp.secondaryBrownColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 8.h),
          text(
            title: 'ابدأ بإضافة منتجاتك المفضلة',
            color: Colors.grey,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: 200.w,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.primaryGreenColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: text(
                title: 'تسوق الآن',
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(CartController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.shopping_basket, color: Colors.white, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                text(
                  title: 'المنتجات (${controller.itemCount})',
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.cartItems.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              final item = controller.cartItems[index];
              return _buildCartItem(item, controller);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItemModel item, CartController controller) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: item.product.image != null
                ? CachedNetworkImage(
                    imageUrl: item.product.image!,
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) {
                      return Container(
                        width: 80.w,
                        height: 80.h,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.image, size: 40.sp, color: Colors.grey),
                      );
                    },
                  )
                : Container(
                    width: 80.w,
                    height: 80.h,
                    color: Colors.grey.shade200,
                    child: Icon(Icons.image, size: 40.sp, color: Colors.grey),
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: item.product.name,
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 4.h),
                text(
                  title: item.product.description,
                  color: Colors.grey.shade600,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        final offsetAnimation = Tween<Offset>(
                          begin: const Offset(0, -0.5),
                          end: Offset.zero,
                        ).animate(animation);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: FadeTransition(opacity: animation, child: child),
                        );
                      },
                      child: Row(
                        key: ValueKey<double>(item.subtotal),
                        children: [
                          text(
                            title: item.subtotal.toStringAsFixed(0),
                            color: ColorsApp.primaryGreenColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 4.w),
                          text(
                            title: 'ج',
                            color: ColorsApp.primaryGreenColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => controller.decreaseQuantity(item.id, item.quantity),
                          child: Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 16.sp,
                              color: ColorsApp.secondaryBrownColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        text(
                          title: item.quantity.toString(),
                          color: ColorsApp.secondaryBrownColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 12.w),
                        InkWell(
                          onTap: () => controller.increaseQuantity(item.id, item.quantity),
                          child: Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorsApp.primaryGreenColor,
                                  ColorsApp.secondaryBrownColor,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(Icons.add, size: 16.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: () => controller.removeCartItem(item.id),
            icon: Icon(Icons.delete_outline, color: Colors.red, size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponSection(CartController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Obx(() {
        if (controller.isCouponApplied.value) {
          return Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: ColorsApp.withOpacity(Colors.green, 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(
                      title: 'تم تفعيل الكوبون',
                      color: Colors.green,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    text(
                      title: controller.couponCode.value,
                      color: Colors.grey.shade600,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.isCouponApplied.value = false;
                  controller.couponCode.value = '';
                  controller.fetchCart();
                },
                icon: Icon(Icons.close, color: Colors.red, size: 20.sp),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_offer, color: ColorsApp.primaryGreenColor, size: 20.sp),
                SizedBox(width: 8.w),
                text(
                  title: 'لديك كوبون خصم؟',
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => controller.couponCode.value = value,
                    style: TextStyle(fontFamily: cairo),
                    decoration: InputDecoration(
                      hintText: 'أدخل كود الخصم',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14.sp,
                        fontFamily: cairo,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: ColorsApp.primaryGreenColor),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  height: 48.h,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isCouponLoading.value
                          ? null
                          : () {
                              if (controller.couponCode.value.isNotEmpty) {
                                controller.redeemCoupon(controller.couponCode.value);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.primaryGreenColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        disabledBackgroundColor: ColorsApp.withOpacity(
                          ColorsApp.primaryGreenColor,
                          0.6,
                        ),
                      ),
                      child: controller.isCouponLoading.value
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : text(
                              title: 'تفعيل',
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSummaryCard(CartController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.05),
            ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                title: 'المجموع الكلي',
                color: ColorsApp.secondaryBrownColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Row(
                  key: ValueKey<double>(controller.total),
                  children: [
                    text(
                      title: controller.total.toStringAsFixed(0),
                      color: ColorsApp.primaryGreenColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 4.w),
                    text(
                      title: 'ج',
                      color: ColorsApp.primaryGreenColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(CartController controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: ColorsApp.backgroundColor),
      child: SafeArea(
        child: SizedBox(
          height: 56.h,
          child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen(), transition: Transition.fadeIn),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsApp.primaryGreenColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                text(
                  title: 'إتمام الطلب',
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, CartController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: text(
          title: 'إفراغ السلة',
          color: ColorsApp.secondaryBrownColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        content: text(
          title: 'هل أنت متأكد من إفراغ السلة؟',
          color: Colors.grey.shade700,
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: text(
              title: 'إلغاء',
              color: Colors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.clearCart();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: text(
              title: 'إفراغ',
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
