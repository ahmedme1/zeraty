import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class SearchCategoryShimmer extends StatelessWidget {
  const SearchCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.7),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 120.w, height: 18.h, color: Colors.grey.shade300),
            SizedBox(height: 4.h),
            Container(width: 180.w, height: 14.h, color: Colors.grey.shade300),
            SizedBox(height: 12.h),
            ...List.generate(3, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Container(
                  width: double.infinity,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
