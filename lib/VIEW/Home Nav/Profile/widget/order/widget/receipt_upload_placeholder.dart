import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ReceiptUploadPlaceholder extends StatelessWidget {
  final OrderPaymentController controller;

  const ReceiptUploadPlaceholder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: controller.pickReceiptImage,
          child: Container(
            width: double.infinity,
            height: 140.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.35),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorsApp.withOpacity(Colors.black, 0.04),
                  blurRadius: 8.r,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    color: ColorsApp.primaryGreenColor,
                    size: 28.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                text(
                  title: 'اضغط لرفع صورة الإيصال',
                  color: ColorsApp.primaryGreenColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
                SizedBox(height: 4.h),
                text(
                  title: 'PNG, JPG حتى 10 ميجا',
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: ReceiptSourceButton(
                icon: Icons.photo_library_outlined,
                label: 'من المعرض',
                onTap: controller.pickReceiptImage,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: ReceiptSourceButton(
                icon: Icons.camera_alt_outlined,
                label: 'من الكاميرا',
                onTap: controller.pickFromCamera,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
