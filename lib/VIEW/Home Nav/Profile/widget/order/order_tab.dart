import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class OrdersTab extends StatelessWidget {
  final ProfileController controller;

  const OrdersTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const OrdersShimmer();
      }

      if (controller.orders.isEmpty) {
        return RefreshIndicator(
          color: ColorsApp.primaryGreenColor,
          onRefresh: () => controller.fetchOrders(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.receipt_long_outlined,
                        size: 60.sp,
                        color: ColorsApp.primaryGreenColor,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    text(
                      title: 'لا توجد طلبات',
                      color: ColorsApp.secondaryBrownColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 8.h),
                    text(
                      title: 'ابدأ بالتسوق الآن',
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        color: ColorsApp.primaryGreenColor,
        onRefresh: () => controller.fetchOrders(),
        child: ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.orders.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return OrderCard(order: order);
          },
        ),
      );
    });
  }
}
