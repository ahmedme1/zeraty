import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchControllers>();

    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      appBar: CustomAppBar(title: 'نتائج البحث', backButton: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.searchResults.isEmpty) {
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
                  child: Icon(Icons.search_off, size: 60.sp, color: ColorsApp.primaryGreenColor),
                ),
                SizedBox(height: 24.h),
                text(
                  title: 'لا توجد نتائج',
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 8.h),
                text(
                  title: 'حاول البحث بكلمات مختلفة',
                  color: Colors.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              SearchResultsHeader(controller: controller),
              SizedBox(height: 16.h),
              SearchResultsGrid(controller: controller),
              SizedBox(height: 24.h),
            ],
          ),
        );
      }),
    );
  }
}

class SearchResultsHeader extends StatelessWidget {
  final SearchControllers controller;

  const SearchResultsHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: 'تم العثور على ${controller.searchResults.length} منتج',
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                if (controller.pagination.value != null)
                  text(
                    title:
                        'صفحة ${controller.pagination.value!.currentPage} من ${controller.pagination.value!.lastPage}',
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultsGrid extends StatelessWidget {
  final SearchControllers controller;

  const SearchResultsGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.7,
        ),
        itemCount: controller.searchResults.length,
        itemBuilder: (context, index) {
          final product = controller.searchResults[index];
          return SearchProductCard(product: product);
        },
      ),
    );
  }
}

class SearchProductCard extends StatelessWidget {
  final SearchProductModel product;

  const SearchProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.to(() => ProductDetailsScreen(productId: product.id), transition: Transition.fadeIn),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: product.image != null
                  ? CachedNetworkImage(
                      imageUrl: product.image!,
                      width: double.infinity,
                      height: 120.h,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 120.h,
                          color: Colors.grey.shade100,
                          child: Icon(Icons.image, size: 50.sp, color: Colors.grey.shade400),
                        );
                      },
                    )
                  : Container(
                      width: double.infinity,
                      height: 120.h,
                      color: Colors.grey.shade100,
                      child: Icon(Icons.image, size: 50.sp, color: Colors.grey.shade400),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(
                      title: product.name,
                      color: ColorsApp.secondaryBrownColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.category, size: 12.sp, color: Colors.grey.shade600),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: text(
                            title: product.category.name,
                            color: Colors.grey.shade600,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.business, size: 12.sp, color: Colors.grey.shade600),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: text(
                            title: product.company.name,
                            color: Colors.grey.shade600,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            text(
                              title: product.finalPrice.toStringAsFixed(0),
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: product.stock > 0
                                ? ColorsApp.withOpacity(Colors.green, 0.1)
                                : ColorsApp.withOpacity(Colors.red, 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: text(
                            title: product.stock > 0 ? 'متوفر' : 'نفذ',
                            color: product.stock > 0 ? Colors.green : Colors.red,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
