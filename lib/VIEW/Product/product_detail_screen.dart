import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(productId: productId),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: ColorsApp.backgroundColor,

            body: Obx(() {
              if (controller.isLoading.value) {
                return const ProductDetailsShimmer();
              }

              if (controller.productDetails.value == null) {
                return const Center(child: Text('لا توجد بيانات'));
              }

              final product = controller.productDetails.value!;

              return CustomScrollView(
                slivers: [
                  _ProductImageSliverAppBar(product: product),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        _ProductInfoSection(product: product),
                        SizedBox(height: 16.h),
                        if (product.features.isNotEmpty)
                          _ProductFeaturesSection(title: 'خصائص', items: product.features),
                        if (product.features.isNotEmpty) SizedBox(height: 16.h),
                        if (product.specifications.isNotEmpty)
                          _ProductFeaturesSection(
                            title: 'المواصفات',
                            items: product.specifications,
                          ),
                        if (product.specifications.isNotEmpty) SizedBox(height: 16.h),
                        _ShippingOptionsSection(controller: controller),
                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ],
              );
            }),
            bottomNavigationBar: Obx(() {
              if (controller.productDetails.value == null) {
                return const SizedBox.shrink();
              }
              return AddToCartButtonInDetail(controller: controller);
            }),
          ),
        );
      },
    );
  }
}

class _ProductImageSliverAppBar extends StatelessWidget {
  final ProductDetailsModel product;

  const _ProductImageSliverAppBar({required this.product});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: EdgeInsets.all(8.w),
        child: InkWell(
          onTap: () => Get.back(),
          child: Container(
            height: 48.h,
            width: 48.w,
            decoration: BoxDecoration(
              color: ColorsApp.withOpacity(Colors.white, 0.9),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: ColorsApp.withOpacity(Colors.black, 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.arrow_back, color: ColorsApp.secondaryBrownColor, size: 18.sp),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.grey.shade200,
          child: product.image != null
              ? Image.network(product.image!, fit: BoxFit.cover)
              : Icon(Icons.image, size: 100.sp, color: Colors.grey),
        ),
      ),
    );
  }
}

class _ProductInfoSection extends StatelessWidget {
  final ProductDetailsModel product;

  const _ProductInfoSection({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
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
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.1),
            ),
            child: text(
              title: product.category.name,
              color: ColorsApp.secondaryBrownColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 8.h),
          text(
            title: product.name,
            color: ColorsApp.secondaryBrownColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 8.h),
          text(
            title: product.description,
            color: ColorsApp.textDarkColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              text(
                title: product.finalPrice.toStringAsFixed(0),
                color: Colors.red,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 4.w),
              text(title: 'ج', color: Colors.red, fontSize: 30.sp, fontWeight: FontWeight.bold),
            ],
          ),
          if (product.stock > 0) ...[
            SizedBox(height: 8.h),
            text(
              title: 'متوفر: ${product.stock} قطعة',
              color: Colors.green,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ],
        ],
      ),
    );
  }
}

class _ProductFeaturesSection extends StatelessWidget {
  final String title;
  final List<String> items;

  const _ProductFeaturesSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
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
          text(
            title: title,
            color: ColorsApp.secondaryBrownColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 16.h),
          ...List.generate(items.length, (index) {
            return _FeatureItem(number: index + 1, feature: items[index]);
          }),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final int number;
  final String feature;

  const _FeatureItem({required this.number, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsApp.secondaryBrownColor, ColorsApp.primaryGreenColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: text(
                title: number.toString(),
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: text(
              title: feature,
              color: ColorsApp.textDarkColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShippingOptionsSection extends StatelessWidget {
  final ProductDetailsController controller;

  const _ShippingOptionsSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          colors: [
            ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.05),
            ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(
              title: 'المميزات',
              color: Colors.black87,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                ShippingCard(
                  icon: '✓',
                  title: 'جودة عالية',
                  color: Colors.green,
                  isSelected: controller.selectedShipping.value == 0,
                  onTap: () => controller.selectShipping(0),
                ),
                SizedBox(width: 12.w),
                ShippingCard(
                  icon: '🌱',
                  title: 'نتائج مضمونة',
                  color: Colors.green,
                  isSelected: controller.selectedShipping.value == 1,
                  onTap: () => controller.selectShipping(1),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                ShippingCard(
                  icon: '🏆',
                  title: 'موثوق',
                  color: Colors.red,
                  isSelected: controller.selectedShipping.value == 2,
                  onTap: () => controller.selectShipping(2),
                ),
                SizedBox(width: 12.w),
                ShippingCard(
                  icon: '💯',
                  title: 'أسعار منافسة',
                  color: Colors.orange,
                  isSelected: controller.selectedShipping.value == 3,
                  onTap: () => controller.selectShipping(3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShippingCard extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ShippingCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isSelected ? ColorsApp.withOpacity(color, 0.9) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              text(title: icon, fontSize: 24.sp, fontWeight: FontWeight.w600),
              SizedBox(height: 8.h),
              text(
                title: title,
                color: Colors.black87,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuantitySection extends StatelessWidget {
  final ProductDetailsController controller;

  const QuantitySection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(
            title: 'الكمية',
            color: Colors.black87,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              InkWell(
                onTap: () => controller.increaseQuantity(),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F4F6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.add, color: ColorsApp.secondaryBrownColor, size: 20.sp),
                ),
              ),
              SizedBox(width: 24.w),
              text(
                title: controller.quantity.value.toString(),
                color: Colors.black87,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 24.w),
              InkWell(
                onTap: () => controller.decreaseQuantity(),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F4F6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.remove, color: ColorsApp.secondaryBrownColor, size: 20.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddToCartButtonInDetail extends StatelessWidget {
  final ProductDetailsController controller;

  const AddToCartButtonInDetail({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10.h,
          children: [
            QuantitySection(controller: controller),
            Obx(
              () => SizedBox(
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (getToken().isNotEmpty) {
                      controller.toggleCart();
                    } else {
                      CustomSnackbar.warning('يرجى تسجيل الدخول لإضافة المنتج إلى السلة');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isInCart.value
                        ? Colors.green.shade600
                        : ColorsApp.secondaryBrownColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        controller.isInCart.value ? Icons.check : Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      text(
                        title: controller.isInCart.value
                            ? 'في السلة ✓'
                            : 'اضف الى السلة - ${controller.totalPrice.toStringAsFixed(0)} ج',
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
