import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      init: FavoriteController(),
      builder: (controller) {
        return CustomStatusBar(
          child: Scaffold(
            backgroundColor: ColorsApp.backgroundColor,
            appBar: CustomAppBar(title: 'المفضلة'),
            body: CheckLogin(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const FavoriteShimmer();
                }

                if (controller.wishlistItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 80.sp, color: Colors.grey),
                        SizedBox(height: 16.h),
                        text(
                          title: 'لا توجد منتجات في المفضلة',
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: List.generate(controller.wishlistItems.length, (index) {
                      final wishlistItem = controller.wishlistItems[index];
                      final product = wishlistItem.product;

                      return GestureDetector(
                        onTap: () => Get.to(
                          () => ProductDetailsScreen(productId: product.id),
                          transition: Transition.fade,
                        ),
                        child: ProductCard(
                          id: product.id,
                          image: product.image ?? '',
                          title: product.name,
                          subtitle: product.description,
                          price: product.finalPrice,
                          isFavorite: true,
                          isInCart: product.isInCart,
                          onFav: () => controller.removeFromWishlist(wishlistItem.id),
                          onAdd: () {
                            final cartController = Get.find<CartController>();
                            controller.wishlistItems[index] = WishlistItemModel(
                              id: wishlistItem.id,
                              product: product.copyWith(isInCart: !product.isInCart),
                              addedAt: wishlistItem.addedAt,
                            );
                            controller.update();

                            if (product.isInCart) {
                              final cartItem = cartController.cartItems.firstWhereOrNull(
                                (item) => item.product.id == product.id,
                              );
                              if (cartItem != null) {
                                cartController.removeCartItem(cartItem.id);
                              }
                            } else {
                              cartController.addToCart(product.id, 1);
                            }
                          },
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final int id;
  final String image;
  final String title;
  final String subtitle;
  final double price;
  final bool isFavorite;
  final bool isInCart;
  final VoidCallback onFav;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isFavorite,
    required this.isInCart,
    required this.onFav,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.h,
      width: 165.w,
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
          ProductImage(image: image, isFavorite: isFavorite, onFav: onFav),
          ProductContent(
            title: title,
            subtitle: subtitle,
            price: price,
            onAdd: onAdd,
            isInCart: isInCart,
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String image;
  final bool isFavorite;
  final VoidCallback onFav;

  const ProductImage({
    super.key,
    required this.image,
    required this.isFavorite,
    required this.onFav,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          child: image.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: image,
                  width: double.infinity,
                  height: 100.h,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 100.h,
                      color: Colors.grey.shade200,
                      child: Icon(Icons.image, size: 50.sp, color: Colors.grey.shade400),
                    );
                  },
                )
              : Container(
                  width: double.infinity,
                  height: 100.h,
                  color: Colors.grey.shade200,
                  child: Icon(Icons.image, size: 50.sp, color: Colors.grey.shade400),
                ),
        ),
        if (getToken().isNotEmpty)
          Positioned(
            top: 8.h,
            left: 8.w,
            child: InkWell(
              onTap: onFav,
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorsApp.withOpacity(Colors.black, 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey.shade600,
                  size: 18.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ProductContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final bool isInCart;
  final VoidCallback onAdd;

  const ProductContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isInCart,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: SizedBox(
        height: 110.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(title: title, color: Colors.black87, fontSize: 12.sp, fontWeight: FontWeight.bold),
            SizedBox(height: 4.h),
            text(
              title: subtitle,
              color: Colors.grey.shade600,
              fontSize: 9.sp,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            PriceSection(price: price),
            SizedBox(height: 8.h),
            if (getToken().isNotEmpty) AddToCartButton(onAdd: onAdd, isInCart: isInCart),
          ],
        ),
      ),
    );
  }
}

class PriceSection extends StatelessWidget {
  final double price;

  const PriceSection({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        text(
          title: price.toStringAsFixed(0),
          color: Colors.red,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(width: 2.w),
        text(title: 'ج', color: Colors.red, fontSize: 12.sp, fontWeight: FontWeight.bold),
      ],
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final VoidCallback onAdd;
  final bool isInCart;

  const AddToCartButton({super.key, required this.onAdd, required this.isInCart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30.h,
      child: ElevatedButton(
        onPressed: onAdd,
        style: ElevatedButton.styleFrom(
          backgroundColor: isInCart ? Colors.green.shade600 : ColorsApp.secondaryBrownColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isInCart ? Icons.check : Icons.add, size: 12.sp, color: Colors.white),
            SizedBox(width: 6.w),
            text(
              title: isInCart ? 'في السلة' : 'اضف إلى السلة',
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
