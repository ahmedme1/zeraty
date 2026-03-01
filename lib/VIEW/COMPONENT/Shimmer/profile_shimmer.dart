import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            _line(180.w, 24.h),
            SizedBox(height: 24.h),
            ...List.generate(6, (_) => _field()),
            SizedBox(height: 32.h),
            _box(double.infinity, 50.h, 25.r),
            SizedBox(height: 12.h),
            _box(double.infinity, 50.h, 25.r),
          ],
        ),
      ),
    );
  }

  Widget _field() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _line(120.w, 16.h),
          SizedBox(height: 8.h),
          _box(double.infinity, 50.h, 12.r),
        ],
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
