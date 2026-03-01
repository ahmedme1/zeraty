import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class PhoneInfo extends StatelessWidget {
  const PhoneInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneController>(
      init: PhoneController(),
      builder: (controller) {
        return Obx(() {
          if (controller.isLoading.value) {
            return PhoneInfoShimmer();
          }

          if (controller.phoneNumbers.isEmpty) {
            return SizedBox.shrink();
          }

          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1.r, spreadRadius: 1.r)],
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48.h,
                  width: 48.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.1),
                  ),
                  child: SvgPicture.asset(
                    ImagesApp.phone,
                    colorFilter: ColorFilter.mode(ColorsApp.secondaryBrownColor, BlendMode.srcIn),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(
                        title: 'الهاتف',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorsApp.secondaryBrownColor,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 5.h),
                      ...controller.phoneNumbers.map((phone) {
                        return PhoneItem(phone: phone);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class PhoneItem extends StatelessWidget {
  final PhoneNumberModel phone;

  const PhoneItem({super.key, required this.phone});

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: () => makePhoneCall(phone.phoneNumber),
        child: Row(
          children: [
            Container(
              width: 6.w,
              height: 6.h,
              decoration: BoxDecoration(color: ColorsApp.primaryGreenColor, shape: BoxShape.circle),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: text(
                title: phone.phoneNumber,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ColorsApp.primaryGreenColor,
                textAlign: TextAlign.start,
                decoration: TextDecoration.underline,
              ),
            ),
            Icon(Icons.phone, color: ColorsApp.primaryGreenColor, size: 20.sp),
          ],
        ),
      ),
    );
  }
}

class PhoneInfoShimmer extends StatelessWidget {
  const PhoneInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 80.w, height: 16.h, color: Colors.white),
                  SizedBox(height: 8.h),
                  Container(width: 150.w, height: 18.h, color: Colors.white),
                  SizedBox(height: 8.h),
                  Container(width: 150.w, height: 18.h, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
