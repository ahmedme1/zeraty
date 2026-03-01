import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class BannerDetailsScreen extends StatelessWidget {
  final BannerModel banner;

  const BannerDetailsScreen({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: CustomScrollView(
          slivers: [
            BannerDetailsSliverAppBar(banner: banner),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  BannerDetailsContent(banner: banner),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerDetailsSliverAppBar extends StatelessWidget {
  final BannerModel banner;

  const BannerDetailsSliverAppBar({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: banner.image != null ? 300.h : 0,
      pinned: true,
      backgroundColor: ColorsApp.primaryGreenColor,
      leading: Padding(
        padding: EdgeInsets.all(8.w),
        child: InkWell(
          onTap: () => Get.back(),
          child: Container(
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
      flexibleSpace: banner.image != null
          ? FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: banner.image!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => BannerDetailsShimmer(),
                    errorWidget: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: Icon(Icons.image, size: 100.sp, color: Colors.grey.shade400),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [ColorsApp.withOpacity(Colors.black, 0.3), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class BannerDetailsContent extends StatelessWidget {
  final BannerModel banner;

  const BannerDetailsContent({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.campaign, color: Colors.white, size: 24.sp),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: text(
                  title: banner.title,
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.description, color: ColorsApp.primaryGreenColor, size: 20.sp),
                    SizedBox(width: 8.w),
                    text(
                      title: 'التفاصيل',
                      color: ColorsApp.primaryGreenColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                text(
                  title: banner.description ?? 'لا يوجد وصف متاح',
                  color: Colors.grey.shade700,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.grey.shade600, size: 16.sp),
              SizedBox(width: 6.w),
              text(
                title: banner.createdAt,
                color: Colors.grey.shade600,
                fontSize: 13.sp,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BannerDetailsShimmer extends StatelessWidget {
  const BannerDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(color: Colors.white),
    );
  }
}
