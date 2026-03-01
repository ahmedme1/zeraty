import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class AddressInfo extends StatelessWidget {
  const AddressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      init: AddressController(),
      builder: (controller) {
        return Obx(() {
          if (controller.isLoading.value) {
            return AddressInfoShimmer();
          }

          if (controller.addresses.isEmpty) {
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
                    ImagesApp.location,
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
                        title: 'العنوان',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorsApp.secondaryBrownColor,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 5.h),
                      ...controller.addresses.map((address) {
                        return AddressItem(address: address);
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

class AddressItem extends StatelessWidget {
  final AddressModel address;

  const AddressItem({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: ColorsApp.primaryGreenColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: text(
                  title: address.title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.primaryGreenColor,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: address.city,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsApp.primaryGreenColor,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 2.h),
                text(
                  title: address.address,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade700,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddressInfoShimmer extends StatelessWidget {
  const AddressInfoShimmer({super.key});

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
                  Container(width: 100.w, height: 16.h, color: Colors.white),
                  SizedBox(height: 8.h),
                  Container(width: double.infinity, height: 14.h, color: Colors.white),
                  SizedBox(height: 8.h),
                  Container(width: double.infinity, height: 14.h, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
