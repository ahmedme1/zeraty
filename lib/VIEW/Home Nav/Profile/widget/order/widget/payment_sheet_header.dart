import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class PaymentSheetHeader extends StatelessWidget {
  const PaymentSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF558B2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorsApp.withOpacity(const Color(0xFF2E7D32), 0.3),
            blurRadius: 14.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.h,
            decoration: BoxDecoration(
              color: ColorsApp.withOpacity(Colors.white, 0.2),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(Icons.agriculture_rounded, color: Colors.white, size: 28.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: 'إتمام عملية الدفع',
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 17.sp,
                ),
                SizedBox(height: 5.h),
                text(
                  title: 'اختر طريقة الدفع وأرسل إيصال التحويل',
                  color: ColorsApp.withOpacity(Colors.white, 0.85),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
