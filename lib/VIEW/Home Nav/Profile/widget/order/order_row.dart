import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.to(() => OrderDetailsScreen(orderId: order.id), transition: Transition.fadeIn),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.withOpacity(Colors.black, 0.05),
              blurRadius: 10.r,
              offset: const Offset(0, 2),
            ),
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
                  child: Icon(Icons.receipt_long, color: Colors.white, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(
                        title: 'طلب رقم #${order.id}',
                        color: ColorsApp.secondaryBrownColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                      SizedBox(height: 4.h),
                      text(
                        title: order.createdAt,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ColorsApp.withOpacity(order.statusColor, 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.info_outline, size: 14.sp, color: order.statusColor),
                      SizedBox(width: 4.w),
                      text(
                        title: order.statusText,
                        color: order.statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_basket_outlined,
                        size: 18.sp,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: 8.w),
                      text(
                        title: 'عدد المنتجات:',
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      text(
                        title: '${order.itemsCount}',
                        color: ColorsApp.secondaryBrownColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      text(
                        title: 'المجموع: ',
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      text(
                        title: '${order.finalAmount.toStringAsFixed(0)} ج',
                        color: ColorsApp.primaryGreenColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (order.status == 'processing' && !order.isReceiptUploaded)
              ProcessingPaymentBanner(orderId: order.id),

            if (order.status == 'processing' && order.isReceiptUploaded)
              ReceiptPendingReviewBanner(),
          ],
        ),
      ),
    );
  }
}

class OrderStatusRow extends StatelessWidget {
  final String status;
  final Color statusColor;

  const OrderStatusRow({super.key, required this.status, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        text(
          title: 'طلب رقم:',
          color: ColorsApp.secondaryBrownColor,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: ColorsApp.withOpacity(statusColor, 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              Icon(Icons.local_shipping_outlined, size: 16, color: statusColor),
              SizedBox(width: 6.w),
              text(title: status, color: statusColor, fontWeight: FontWeight.w600, fontSize: 13),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderNumberRow extends StatelessWidget {
  final String orderNumber;

  const OrderNumberRow({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        text(
          title: orderNumber,
          color: ColorsApp.secondaryBrownColor,
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
        ),
      ],
    );
  }
}

class OrderDateRow extends StatelessWidget {
  final String date;

  const OrderDateRow({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        text(
          title: date,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ],
    );
  }
}

class OrderItemsRow extends StatelessWidget {
  final int itemCount;

  const OrderItemsRow({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text(
          title: 'عدد المنتجات:',
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
        text(
          title: '$itemCount منتج',
          color: ColorsApp.secondaryBrownColor,
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
        ),
      ],
    );
  }
}

class OrderTotalRow extends StatelessWidget {
  final double totalPrice;

  const OrderTotalRow({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text(
          title: 'الإجمالي:',
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
        text(
          title: 'ج.م $totalPrice',
          color: ColorsApp.primaryGreenColor,
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
      ],
    );
  }
}

class ReceiptPendingReviewBanner extends StatelessWidget {
  const ReceiptPendingReviewBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 14.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE8F5E9), Color(0xFFF1F8E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorsApp.withOpacity(Color(0xFF66BB6A), 0.5), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: ColorsApp.withOpacity(Color(0xFF66BB6A), 0.1),
            blurRadius: 8.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF43A047), Color(0xFF2E7D32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: ColorsApp.withOpacity(const Color(0xFF43A047), 0.3),
                  blurRadius: 8.r,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(Icons.hourglass_top_rounded, color: Colors.white, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: 'تم رفع الإيصال بنجاح',
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.w800,
                  fontSize: 14.sp,
                ),
                SizedBox(height: 3.h),
                text(
                  title: 'في انتظار مراجعة الإيصال من الإدارة',
                  color: Color(0xFF558B2F),
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle_rounded, color: Color(0xFF43A047), size: 22.sp),
        ],
      ),
    );
  }
}
