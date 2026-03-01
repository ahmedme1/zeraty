import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class PaymentSubmitButton extends StatelessWidget {
  final int orderId;
  final OrderPaymentController controller;

  const PaymentSubmitButton({super.key, required this.orderId, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = controller.isSubmitting.value;
      return GestureDetector(
        onTap: isLoading
            ? null
            : () async {
                final success = await controller.submitPayment(orderId: orderId);
                if (success) {
                  controller.resetState();
                  Get.back();
                  Get.find<ProfileController>().fetchOrders();
                }
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isLoading
                  ? [Colors.grey.shade400, Colors.grey.shade300]
                  : [const Color(0xFF2E7D32), const Color(0xFF558B2F)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: isLoading
                ? []
                : [
                    BoxShadow(
                      color: ColorsApp.withOpacity(const Color(0xFF2E7D32), 0.4),
                      blurRadius: 14.r,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 22.w,
                  height: 22.h,
                  child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                )
              else
                Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
              SizedBox(width: 10.w),
              text(
                title: isLoading ? 'جاري الإرسال...' : 'إرسال الإيصال',
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16.sp,
              ),
            ],
          ),
        ),
      );
    });
  }
}
