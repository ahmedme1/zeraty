import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ProcessingPaymentBanner extends StatelessWidget {
  final int orderId;

  const ProcessingPaymentBanner({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPaymentSheet(context),
      child: Container(
        margin: EdgeInsets.only(top: 14.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFFFFF8E1), const Color(0xFFFFF3CD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: ColorsApp.withOpacity(Color(0xFFFFB300), 0.5), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.withOpacity(const Color(0xFFFFB300), 0.12),
              blurRadius: 8.r,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFB300), Color(0xFFFF8F00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.withOpacity(const Color(0xFFFFB300), 0.35),
                    blurRadius: 8.r,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(Icons.payment_rounded, color: Colors.white, size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(
                    title: 'في انتظار الدفع',
                    color: const Color(0xFFE65100),
                    fontWeight: FontWeight.w800,
                    fontSize: 14.sp,
                  ),
                  SizedBox(height: 3.h),
                  text(
                    title: 'أرسل إيصال التحويل لإتمام طلبك',
                    color: const Color(0xFF8D6E63),
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFFB300), Color(0xFFFF8F00)]),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.withOpacity(const Color(0xFFFFB300), 0.4),
                    blurRadius: 6.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  text(
                    title: 'ادفع الآن',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                  SizedBox(width: 5.w),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 11.sp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openPaymentSheet(BuildContext context) {
    final controller = Get.put(OrderPaymentController());
    controller.fetchPaymentMethods();
    Get.bottomSheet(
      PaymentBottomSheet(orderId: orderId, controller: controller),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
