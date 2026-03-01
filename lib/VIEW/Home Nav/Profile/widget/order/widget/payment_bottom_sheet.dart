import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class PaymentBottomSheet extends StatelessWidget {
  final int orderId;
  final OrderPaymentController controller;

  const PaymentBottomSheet({super.key, required this.orderId, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBF5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
      ),
      child: Column(
        children: [
          PaymentSheetHandle(),
          PaymentSheetHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  PaymentMethodsSection(controller: controller),
                  SizedBox(height: 20.h),
                  ReceiptUploadSection(controller: controller),
                  SizedBox(height: 24.h),
                  PaymentSubmitButton(orderId: orderId, controller: controller),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
