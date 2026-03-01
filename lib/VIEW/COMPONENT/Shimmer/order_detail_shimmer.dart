import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class OrderDetailsShimmer extends StatelessWidget {
  const OrderDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _statusShimmer(),
            SizedBox(height: 16.h),
            _cardShimmer(lines: 3),
            SizedBox(height: 16.h),
            _cardShimmer(lines: 3),
            SizedBox(height: 16.h),
            _itemsShimmer(),
            SizedBox(height: 16.h),
            _summaryShimmer(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _statusShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          ),
          SizedBox(height: 16.h),
          Container(width: 120.w, height: 18.h, color: Colors.grey),
          SizedBox(height: 8.h),
          Container(width: 100.w, height: 12.h, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _cardShimmer({int lines = 3}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 140.w, height: 16.h, color: Colors.grey),
          SizedBox(height: 16.h),
          ...List.generate(
            lines,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(width: double.infinity, height: 12.h, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemsShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Container(width: 150.w, height: 16.h, color: Colors.grey),
          ),
          ...List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(width: 70.w, height: 70.h, color: Colors.grey),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 120.w, height: 14.h, color: Colors.grey),
                        SizedBox(height: 6.h),
                        Container(width: double.infinity, height: 10.h, color: Colors.grey),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 60.w, height: 12.h, color: Colors.grey),
                            Container(width: 40.w, height: 12.h, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(width: 140.w, height: 16.h, color: Colors.grey),
          SizedBox(height: 16.h),
          ...List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 80.w, height: 12.h, color: Colors.grey),
                  Container(width: 60.w, height: 12.h, color: Colors.grey),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 100.w, height: 16.h, color: Colors.grey),
              Container(width: 80.w, height: 18.h, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
