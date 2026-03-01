import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class PaymentSectionTitle extends StatelessWidget {
  final IconData icon;
  final String label;

  const PaymentSectionTitle({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: ColorsApp.primaryGreenColor, size: 17.sp),
        ),
        SizedBox(width: 10.w),
        text(
          title: label,
          color: ColorsApp.secondaryBrownColor,
          fontWeight: FontWeight.w800,
          fontSize: 15.sp,
        ),
      ],
    );
  }
}
