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
            appBar: CustomAppBar(title: 'المفضلة', backButton: true),
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
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      childAspectRatio: 165.w / 240.h,
                    ),
                    itemCount: controller.wishlistItems.length,
                    itemBuilder: (context, index) {
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
                          stock: product.stock,
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
                    },
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
