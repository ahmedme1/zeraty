import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});
  final OrderDetailsModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
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
                  child: Icon(Icons.shopping_basket, color: Colors.white, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                text(
                  title: 'المنتجات (${order.items.length})',
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              final item = order.items[index];
              return OrderItemCard(item: item);
            },
          ),
        ],
      ),
    );
  }
}
