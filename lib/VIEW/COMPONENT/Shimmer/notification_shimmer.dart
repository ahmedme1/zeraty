import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class NotificationsShimmer extends StatelessWidget {
  final int itemCount;

  const NotificationsShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const _NotificationShimmerCard();
      },
    );
  }
}

class _NotificationShimmerCard extends StatelessWidget {
  const _NotificationShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Placeholder
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(width: 160.w, height: 16.h),
                    SizedBox(height: 10.h),
                    _line(width: double.infinity, height: 14.h),
                    SizedBox(height: 6.h),
                    _line(width: 220.w, height: 14.h),
                    SizedBox(height: 10.h),
                    _line(width: 120.w, height: 12.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
    );
  }
}
