import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class PartnerScreen extends StatelessWidget {
  const PartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartnerController>(
      init: PartnerController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorsApp.backgroundColor,
          appBar: CustomAppBar(title: 'شركاء النجاح', backButton: true),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const PartnerShimmer();
            }

            if (controller.companies.isEmpty) {
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
                        Icons.business_outlined,
                        size: 60.sp,
                        color: ColorsApp.primaryGreenColor,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    text(
                      title: 'لا توجد شركات',
                      color: ColorsApp.secondaryBrownColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  ThankYouCard(),
                  SizedBox(height: 24.h),
                  PartnersGrid(controller: controller),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          }),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: SupportButton(),
        );
      },
    );
  }
}

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.1),
            ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.verified, color: Colors.white, size: 30.sp),
          ),
          SizedBox(height: 16.h),
          text(
            title: 'شركاء موثوقون',
            color: ColorsApp.secondaryBrownColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 8.h),
          text(
            title: 'جميع شركائنا معتمدون ويقدمون منتجات عالية الجودة',
            color: ColorsApp.textDarkColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}

class PartnersGrid extends StatelessWidget {
  final PartnerController controller;

  const PartnersGrid({super.key, required this.controller});

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
          childAspectRatio: 0.85,
        ),
        itemCount: controller.companies.length,
        itemBuilder: (context, index) {
          return PartnerCard(
            onTap: () => Get.to(
              () => CompanyProductScreen(
                companyId: controller.companies[index].id,
                companyName: controller.companies[index].name,
              ),
              transition: Transition.fadeIn,
            ),
            company: controller.companies[index],
          );
        },
      ),
    );
  }
}

class PartnerCard extends StatelessWidget {
  const PartnerCard({super.key, required this.company, required this.onTap});
  final CompanyModel company;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: company.logo != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: CachedNetworkImage(
                        imageUrl: company.logo!,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) {
                          return Icon(
                            Icons.business,
                            size: 50.sp,
                            color: ColorsApp.primaryGreenColor,
                          );
                        },
                      ),
                    )
                  : Icon(Icons.business, size: 50.sp, color: ColorsApp.primaryGreenColor),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: text(
                title: company.name,
                color: ColorsApp.secondaryBrownColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                text(
                  title: '${company.productsCount}',
                  color: ColorsApp.primaryGreenColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(width: 4.w),
                text(
                  title: 'منتج',
                  color: Colors.grey.shade600,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
