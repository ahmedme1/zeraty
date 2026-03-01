import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class CompanyDetailsShimmer extends StatelessWidget {
  const CompanyDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 120.w, height: 16.h, color: Colors.grey.shade300),
                        SizedBox(height: 8.h),
                        Container(
                          width: double.infinity,
                          height: 12.h,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 6.h),
                        Container(width: 150.w, height: 12.h, color: Colors.grey.shade300),
                        SizedBox(height: 10.h),
                        Container(width: 80.w, height: 20.h, color: Colors.grey.shade300),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(width: 100.w, height: 16.h, color: Colors.grey.shade300),
              ),
            ),
            SizedBox(height: 16.h),
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
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return const PartnerProductCardShimmer();
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

class PartnerProductCardShimmer extends StatelessWidget {
  const PartnerProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 100.w, height: 14.h, color: Colors.grey.shade300),
                SizedBox(height: 6.h),
                Container(width: double.infinity, height: 10.h, color: Colors.grey.shade300),
                SizedBox(height: 4.h),
                Container(width: 80.w, height: 10.h, color: Colors.grey.shade300),
                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 60.w, height: 14.h, color: Colors.grey.shade300),
                    Container(width: 40.w, height: 16.h, color: Colors.grey.shade300),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
