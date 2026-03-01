import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class ProductsShimmer extends StatelessWidget {
  final int itemCount;

  const ProductsShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: List.generate(itemCount, (_) => const _ProductShimmerCard()),
      ),
    );
  }
}

class _ProductShimmerCard extends StatelessWidget {
  const _ProductShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 160.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(height: 12.h),
            Container(width: double.infinity, height: 16.h, color: Colors.white),
            SizedBox(height: 8.h),
            Container(width: 100.w, height: 14.h, color: Colors.white),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 60.w, height: 20.h, color: Colors.white),
                Container(width: 30.w, height: 20.h, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
