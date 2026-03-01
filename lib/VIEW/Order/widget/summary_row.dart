import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key, required this.label, required this.value, this.isDiscount = false});

  final String label;
  final String value;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(
            title: label,
            color: Colors.grey.shade700,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          text(
            title: value,
            color: isDiscount ? Colors.red : ColorsApp.secondaryBrownColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
