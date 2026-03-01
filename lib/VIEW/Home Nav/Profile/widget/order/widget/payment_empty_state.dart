import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class PaymentEmptyState extends StatelessWidget {
  const PaymentEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: text(
          title: 'لا توجد طرق دفع متاحة حالياً',
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
