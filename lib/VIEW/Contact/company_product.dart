import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class CompanyProductScreen extends StatelessWidget {
  const CompanyProductScreen({super.key, required this.companyId, required this.companyName});

  final int companyId;
  final String companyName;

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return GetBuilder<CompanyDetailsController>(
      init: CompanyDetailsController(companyId: companyId),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorsApp.backgroundColor,
          appBar: CustomAppBar(title: companyName, backButton: true),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const CompanyDetailsShimmer();
            }

            if (controller.companyDetails.value == null) {
              return const Center(child: Text('لا توجد بيانات'));
            }

            final company = controller.companyDetails.value!;

            // ← هنا: بعد ما isLoading خلص مباشرة، قبل ما الـ grid يتبني
            if (productController.allProduct.isEmpty ||
                productController.allProduct.first.id != company.products.first.id) {
              productController.setProducts(company.products);
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  _buildCompanyHeader(company),
                  SizedBox(height: 16.h),
                  if (company.products.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.h),
                        child: Column(
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 80.sp,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(height: 16.h),
                            text(
                              title: 'لا توجد منتجات',
                              color: Colors.grey.shade600,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    const PartnersProductGrid(),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildCompanyHeader(CompanyDetailsModel company) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: company.logo != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: company.logo!,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) {
                        return Icon(
                          Icons.business,
                          size: 40.sp,
                          color: ColorsApp.primaryGreenColor,
                        );
                      },
                    ),
                  )
                : Icon(Icons.business, size: 40.sp, color: ColorsApp.primaryGreenColor),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: company.name,
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.h),
                text(
                  title: company.description,
                  color: Colors.grey.shade600,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.inventory_2, size: 14.sp, color: ColorsApp.primaryGreenColor),
                      SizedBox(width: 4.w),
                      text(
                        title: '${company.products.length} منتج',
                        color: ColorsApp.primaryGreenColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PartnersProductGrid extends StatelessWidget {
  const PartnersProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(
            title: 'المنتجات',
            color: ColorsApp.secondaryBrownColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 16.h),
          Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.h,
                childAspectRatio: getChildAspectRatio(),
              ),
              itemCount: controller.allProduct.length,
              itemBuilder: (context, index) {
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
                    stock: product.stock,
                    isFavorite: product.isFavorite,
                    isInCart: product.isInCart,
                    onFav: () => controller.toggleFavorite(index),
                    onAdd: () => controller.toggleCart(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
