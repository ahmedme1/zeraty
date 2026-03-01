import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(height: 300.h, color: Colors.grey.shade300),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 65.w, height: 20.h, color: Colors.grey.shade300),
                    SizedBox(height: 8.h),
                    Container(width: double.infinity, height: 28.h, color: Colors.grey.shade300),
                    SizedBox(height: 8.h),
                    Container(width: double.infinity, height: 18.h, color: Colors.grey.shade300),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Container(width: 60.w, height: 28.h, color: Colors.grey.shade300),
                        SizedBox(width: 4.w),
                        Container(width: 16.w, height: 28.h, color: Colors.grey.shade300),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 80.w, height: 20.h, color: Colors.grey.shade300),
                        Row(
                          children: [
                            Container(width: 40.w, height: 40.h, color: Colors.grey.shade300),
                            SizedBox(width: 24.w),
                            Container(width: 40.w, height: 20.h, color: Colors.grey.shade300),
                            SizedBox(width: 24.w),
                            Container(width: 40.w, height: 40.h, color: Colors.grey.shade300),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    ...List.generate(3, (index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          children: [
                            Container(width: 24.w, height: 24.h, color: Colors.grey.shade300),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Container(height: 16.h, color: Colors.grey.shade300),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 80.w, height: 20.h, color: Colors.grey.shade300),
                Row(
                  children: [
                    Container(width: 40.w, height: 40.h, color: Colors.grey.shade300),
                    SizedBox(width: 24.w),
                    Container(width: 40.w, height: 20.h, color: Colors.grey.shade300),
                    SizedBox(width: 24.w),
                    Container(width: 40.w, height: 40.h, color: Colors.grey.shade300),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(width: double.infinity, height: 56.h, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
