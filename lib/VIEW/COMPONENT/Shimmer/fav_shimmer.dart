import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class FavoriteShimmer extends StatelessWidget {
  final int itemCount;

  const FavoriteShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: List.generate(itemCount, (index) {
          return const _ShimmerProductCard();
        }),
      ),
    );
  }
}

class _ShimmerProductCard extends StatelessWidget {
  const _ShimmerProductCard();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 240.h,
        width: 165.w,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: Container(height: 100.h, width: double.infinity, color: Colors.white),
            ),

            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line(width: 100.w, height: 12.h),
                  SizedBox(height: 8.h),
                  _line(width: 140.w, height: 8.h),
                  SizedBox(height: 6.h),
                  _line(width: 120.w, height: 8.h),
                  SizedBox(height: 12.h),
                  _line(width: 60.w, height: 12.h),
                  SizedBox(height: 12.h),
                  Container(
                    height: 30.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.r)),
    );
  }
}
