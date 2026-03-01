import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class OrderSummaryInOrderDetail extends StatelessWidget {
  const OrderSummaryInOrderDetail({super.key, required this.order});
  final OrderDetailsModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.05),
            ColorsApp.withOpacity(ColorsApp.secondaryBrownColor, 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.3),
          width: 2,
        ),
      ),
      child: Column(
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
                child: Icon(Icons.receipt, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              text(
                title: 'ملخص الطلب',
                color: ColorsApp.secondaryBrownColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SummaryRow(label: 'المجموع', value: '${order.totalAmount.toStringAsFixed(0)} ج'),
          if (order.discountAmount > 0)
            SummaryRow(
              label: 'الخصم',
              value: '-${order.discountAmount.toStringAsFixed(0)} ج',
              isDiscount: true,
            ),
          Divider(height: 24.h, color: Colors.grey.shade300, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                title: 'المجموع الكلي',
                color: ColorsApp.secondaryBrownColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  text(
                    title: order.finalAmount.toStringAsFixed(0),
                    color: ColorsApp.primaryGreenColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(width: 4.w),
                  text(
                    title: 'ج',
                    color: ColorsApp.primaryGreenColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
