import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.w,
            height: 6.h,
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(color: ColorsApp.primaryGreenColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: label,
                  color: Colors.grey.shade600,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 4.h),
                text(
                  title: value,
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
