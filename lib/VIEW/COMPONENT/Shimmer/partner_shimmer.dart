import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class PartnerShimmer extends StatelessWidget {
  const PartnerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24.h),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
                  ),
                  SizedBox(height: 16.h),
                  Container(width: 120.w, height: 16.h, color: Colors.grey.shade300),
                  SizedBox(height: 8.h),
                  Container(width: 200.w, height: 14.h, color: Colors.grey.shade300),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(width: 80.w, height: 14.h, color: Colors.grey.shade300),
                        SizedBox(height: 6.h),
                        Container(width: 40.w, height: 12.h, color: Colors.grey.shade300),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
