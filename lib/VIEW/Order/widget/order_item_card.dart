import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({super.key, required this.item});
  final OrderItemModel item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: item.product.image != null
                ? CachedNetworkImage(
                    imageUrl: item.product.image!,
                    width: 70.w,
                    height: 70.h,
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) {
                      return Container(
                        width: 70.w,
                        height: 70.h,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.image, size: 30.sp, color: Colors.grey),
                      );
                    },
                  )
                : Container(
                    width: 70.w,
                    height: 70.h,
                    color: Colors.grey.shade200,
                    child: Icon(Icons.image, size: 30.sp, color: Colors.grey),
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: item.product.name,
                  color: ColorsApp.secondaryBrownColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 4.h),
                text(
                  title: item.product.description,
                  color: Colors.grey.shade600,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: ColorsApp.withOpacity(ColorsApp.primaryGreenColor, 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: text(
                        title: 'الكمية: ${item.quantity}',
                        color: ColorsApp.primaryGreenColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        text(
                          title: item.subtotal.toStringAsFixed(0),
                          color: ColorsApp.primaryGreenColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 4.w),
                        text(
                          title: 'ج',
                          color: ColorsApp.primaryGreenColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
