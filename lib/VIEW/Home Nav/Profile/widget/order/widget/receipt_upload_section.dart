import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class ReceiptUploadSection extends StatelessWidget {
  final OrderPaymentController controller;

  const ReceiptUploadSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentSectionTitle(icon: Icons.receipt_long_outlined, label: 'صورة الإيصال'),
        SizedBox(height: 12.h),
        Obx(() {
          if (controller.receiptImage.value != null) {
            return ReceiptImagePreview(controller: controller);
          }
          return ReceiptUploadPlaceholder(controller: controller);
        }),
      ],
    );
  }
}
