import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ReceiptSourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ReceiptSourceButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: ColorsApp.withOpacity(Colors.black, 0.03), blurRadius: 6.r)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.sp, color: ColorsApp.primaryGreenColor),
            SizedBox(width: 6.w),
            text(
              title: label,
              color: ColorsApp.secondaryBrownColor,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ],
        ),
      ),
    );
  }
}
