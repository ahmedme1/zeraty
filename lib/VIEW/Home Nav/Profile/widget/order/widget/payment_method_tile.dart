import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class PaymentMethodTile extends StatelessWidget {
  final PaymentMethodModel method;
  final OrderPaymentController controller;

  const PaymentMethodTile({super.key, required this.method, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedMethod.value?.id == method.id;
      return GestureDetector(
        onTap: () => controller.selectMethod(method),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.06)
                : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? ColorsApp.primaryGreenColor : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1)
                    : ColorsApp.withOpacity(Colors.black, 0.04),
                blurRadius: 8.r,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 22.w,
                height: 22.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? ColorsApp.primaryGreenColor : Colors.grey.shade400,
                    width: 2,
                  ),
                  color: isSelected ? ColorsApp.primaryGreenColor : Colors.transparent,
                ),
                child: isSelected
                    ? Icon(Icons.check_rounded, color: Colors.white, size: 14.sp)
                    : null,
              ),
              SizedBox(width: 14.w),
              Container(
                width: 42.w,
                height: 42.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  _methodIcon(method.name),
                  color: isSelected ? ColorsApp.primaryGreenColor : Colors.grey.shade500,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(
                      title: method.name,
                      color: isSelected
                          ? ColorsApp.primaryGreenColor
                          : ColorsApp.secondaryBrownColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.phone_outlined, size: 13.sp, color: Colors.grey.shade500),
                        SizedBox(width: 4.w),
                        text(
                          title: method.phoneNumber,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isSelected)
                GestureDetector(
                  onTap: () => _copyNumber(method.phoneNumber),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.12),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.copy_rounded, size: 14.sp, color: ColorsApp.primaryGreenColor),
                        SizedBox(width: 4.w),
                        text(
                          title: 'نسخ',
                          color: ColorsApp.primaryGreenColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  IconData _methodIcon(String name) {
    if (name.contains('نقد')) return Icons.money_rounded;
    if (name.contains('فيزا') || name.contains('بطاقة')) return Icons.credit_card_rounded;
    if (name.contains('محفظة') || name.contains('وودي') || name.contains('اورنج')) {
      return Icons.account_balance_wallet_rounded;
    }
    if (name.contains('انستاباي') || name.contains('instapay')) return Icons.swap_horiz_rounded;
    return Icons.payments_rounded;
  }

  void _copyNumber(String number) {
    Clipboard.setData(ClipboardData(text: number));
    CustomSnackbar.success('تم نسخ الرقم'.tr);
  }
}
