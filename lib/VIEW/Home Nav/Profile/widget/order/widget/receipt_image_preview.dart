import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ReceiptImagePreview extends StatelessWidget {
  final OrderPaymentController controller;

  const ReceiptImagePreview({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.4)),
        boxShadow: [
          BoxShadow(
            color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.08),
            blurRadius: 10.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.r),
              topRight: Radius.circular(18.r),
            ),
            child: Image.file(
              controller.receiptImage.value!,
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: ColorsApp.primaryGreenColor, size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: text(
                    title: controller.receiptImageName.value,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
                GestureDetector(
                  onTap: controller.removeImage,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Icons.delete_outline_rounded, color: Colors.red, size: 18.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
