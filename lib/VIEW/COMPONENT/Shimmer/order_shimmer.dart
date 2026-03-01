import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OrdersShimmer extends StatelessWidget {
  final int itemCount;

  const OrdersShimmer({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) => const _OrderShimmerCard(),
    );
  }
}

class _OrderShimmerCard extends StatelessWidget {
  const _OrderShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _box(40.w, 40.h, 10.r),
                SizedBox(width: 12.w),
                Expanded(child: _line(double.infinity, 16.h)),
                SizedBox(width: 12.w),
                _box(80.w, 28.h, 20.r),
              ],
            ),
            SizedBox(height: 16.h),
            _box(double.infinity, 60.h, 12.r),
          ],
        ),
      ),
    );
  }

  Widget _line(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
    );
  }

  Widget _box(double width, double height, double radius) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(radius)),
    );
  }
}
