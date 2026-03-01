import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class ShippingInfoInOrderDetail extends StatelessWidget {
  const ShippingInfoInOrderDetail({super.key, required this.order});
  final OrderDetailsModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorsApp.primaryGreenColor, ColorsApp.secondaryBrownColor],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.location_on, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              text(
                title: 'عنوان الشحن',
                color: ColorsApp.secondaryBrownColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          InfoRow(label: 'المحافظة', value: order.state),
          InfoRow(label: 'العنوان', value: order.address),
          if (order.notes != null && order.notes!.isNotEmpty)
            InfoRow(label: 'ملاحظات', value: order.notes!),
        ],
      ),
    );
  }
}
