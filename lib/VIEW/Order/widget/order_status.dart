import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key, required this.order});
  final OrderDetailsModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorsApp.withOpacity(order.statusColor, 0.1), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsApp.withOpacity(order.statusColor, 0.3), width: 2),
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(color: order.statusColor, shape: BoxShape.circle),
            child: Icon(_getStatusIcon(order.status), color: Colors.white, size: 40.sp),
          ),
          SizedBox(height: 16.h),
          text(
            title: order.statusText,
            color: order.statusColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 8.h),
          text(
            title: 'طلب رقم #${order.id}',
            color: Colors.grey.shade600,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.schedule;
      case 'processing':
        return Icons.settings;
      case 'shipped':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }
}
