import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class PaymentSheetHandle extends StatelessWidget {
  const PaymentSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
      child: Center(
        child: Container(
          width: 42.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
