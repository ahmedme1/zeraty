import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class PaymentMethodsSection extends StatelessWidget {
  final OrderPaymentController controller;

  const PaymentMethodsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentSectionTitle(icon: Icons.account_balance_wallet_outlined, label: 'طرق الدفع'),
        SizedBox(height: 12.h),
        Obx(() {
          if (controller.isLoadingMethods.value) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: CircularProgressIndicator(color: ColorsApp.primaryGreenColor),
              ),
            );
          }

          if (controller.paymentMethods.isEmpty) {
            return PaymentEmptyState();
          }

          return Column(
            children: controller.paymentMethods
                .map((method) => PaymentMethodTile(method: method, controller: controller))
                .toList(),
          );
        }),
      ],
    );
  }
}
