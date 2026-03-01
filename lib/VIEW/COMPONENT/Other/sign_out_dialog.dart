import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ConfirmationDialog {
  static void show({
    required String title,
    required String subtitle,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                padding: EdgeInsets.all(20.w),
                child: _buildQuestionIcon(),
              ),

              SizedBox(height: 24.h),
              text(
                title: title,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8.h),
              text(
                title: subtitle,
                fontSize: 14.sp,
                color: Colors.grey.shade600,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel ?? () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.secondaryBrownColor,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        elevation: 0,
                      ),
                      child: text(
                        title: 'الإلغاء'.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        onConfirm();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.red, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: text(
                        title: 'تسجيل الخروج'.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static Widget _buildQuestionIcon() {
    return CustomPaint(painter: QuestionIconPainter());
  }
}

class QuestionIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFEF4444)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;
    canvas.drawCircle(center, radius, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '?',
        style: TextStyle(
          fontSize: size.width * 0.6,
          fontWeight: FontWeight.bold,
          color: Color(0xFFEF4444),
        ),
      ),
      textDirection: TextDirection.rtl,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
