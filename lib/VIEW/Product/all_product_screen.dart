import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key, required this.categoryId, required this.categoryName});

  final int categoryId;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    controller.fetchCategoryProducts(categoryId);

    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      appBar: CustomAppBar(title: categoryName, backButton: true),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const ProductsShimmer();
          }

          if (controller.allProduct.isEmpty) {
            return Center(
              child: text(title: 'لا توجد منتجات', fontSize: 14.sp),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: List.generate(controller.allProduct.length, (index) {
                  final product = controller.allProduct[index];
                  return GestureDetector(
                    onTap: () => Get.to(
                      () => ProductDetailsScreen(productId: product.id),
                      transition: Transition.fade,
                    )!.then((_) => controller.syncCartState()),
                    child: ProductCard(
                      id: product.id,
                      image: product.image ?? '',
                      title: product.name,
                      subtitle: product.description,
                      price: product.finalPrice,
                      isFavorite: product.isFavorite,
                      isInCart: product.isInCart,
                      onFav: () => controller.toggleFavorite(index),
                      onAdd: () => controller.toggleCart(index),
                    ),
                  );
                }),
              ),
            ),
          );
        }),
      ),
    );
  }
}
