import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(orderId: orderId),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.grey.shade50,
            appBar: CustomAppBar(title: 'تفاصيل الطلب', backButton: true),
            body: Obx(() {
              if (controller.isLoading.value) {
                return const OrderDetailsShimmer();
              }

              if (controller.orderDetails.value == null) {
                return Center(
                  child: text(title: 'لا توجد بيانات', fontSize: 14.sp),
                );
              }

              final order = controller.orderDetails.value!;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    OrderStatus(order: order),
                    SizedBox(height: 16.h),
                    if (order.status == 'processing' && !order.isReceiptUploaded)
                      ProcessingPaymentBanner(orderId: order.id),

                    if (order.status == 'processing' && order.isReceiptUploaded) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ReceiptPendingReviewBanner(),
                      ),
                      SizedBox(height: 16.h),
                    ],
                    OrderInfo(order: order),
                    SizedBox(height: 16.h),
                    ShippingInfoInOrderDetail(order: order),
                    SizedBox(height: 16.h),
                    OrderItems(order: order),
                    SizedBox(height: 16.h),
                    OrderSummaryInOrderDetail(order: order),
                    SizedBox(height: 24.h),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
