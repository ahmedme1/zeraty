import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class BannerCard extends StatelessWidget {
  final BannerModel banner;

  const BannerCard({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (banner.description != null && banner.description!.isNotEmpty) {
          Get.to(() => BannerDetailsScreen(banner: banner), transition: Transition.fadeIn);
        }
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: LinearGradient(
            colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: banner.image != null
            ? BannerWithImage(banner: banner)
            : BannerWithoutImage(banner: banner),
      ),
    );
  }
}

class BannerWithImage extends StatelessWidget {
  final BannerModel banner;

  const BannerWithImage({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: banner.image!,
            fit: BoxFit.cover,
            placeholder: (context, url) => BannerShimmer(),
            errorWidget: (context, error, stackTrace) {
              return BannerWithoutImage(banner: banner);
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsApp.withOpacity(Colors.black, 0.7),
                  ColorsApp.withOpacity(Colors.black, 0.3),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 16.h,
            right: 16.w,
            left: 16.w,
            child: BannerContent(banner: banner),
          ),
        ],
      ),
    );
  }
}

class BannerWithoutImage extends StatelessWidget {
  final BannerModel banner;

  const BannerWithoutImage({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Center(child: BannerContent(banner: banner)),
    );
  }
}

class BannerContent extends StatelessWidget {
  final BannerModel banner;

  const BannerContent({super.key, required this.banner});

  String _getTruncatedDescription() {
    if (banner.description == null || banner.description!.isEmpty) return '';
    if (banner.description!.length <= 50) return banner.description!;
    return '${banner.description!.substring(0, 50)}...';
  }

  bool get _hasMoreContent {
    return banner.description != null && banner.description!.length > 50;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        text(
          title: banner.title,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          textAlign: TextAlign.start,
        ),
        if (banner.description != null && banner.description!.isNotEmpty) ...[
          SizedBox(height: 8.h),
          text(
            title: _getTruncatedDescription(),
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.start,
          ),
          if (_hasMoreContent) ...[
            SizedBox(height: 4.h),
            Row(
              children: [
                text(
                  title: 'اقرأ المزيد',
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
                SizedBox(width: 4.w),
                Icon(Icons.arrow_back, color: Colors.white, size: 14.sp),
              ],
            ),
          ],
        ],
      ],
    );
  }
}

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24.r)),
      ),
    );
  }
}
