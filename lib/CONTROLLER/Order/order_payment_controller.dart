import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class OrderPaymentController extends GetxController {
  final RxList<PaymentMethodModel> paymentMethods = <PaymentMethodModel>[].obs;
  final Rxn<PaymentMethodModel> selectedMethod = Rxn<PaymentMethodModel>();
  final Rxn<File> receiptImage = Rxn<File>();
  final RxBool isLoadingMethods = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxString receiptImageName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPaymentMethods();
  }

  Future<void> fetchPaymentMethods() async {
    isLoadingMethods.value = true;
    try {
      final response = await DioHelper.getData(
        url: EndPoints.paymentMethods,
        sendAuthToken: true,
        silent: true,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final parsed = PaymentMethodsResponse.fromJson(response.data);
        paymentMethods.assignAll(parsed.data.where((m) => m.status).toList());
        if (paymentMethods.isNotEmpty) selectedMethod.value = paymentMethods.first;
      }
    } catch (_) {
    } finally {
      isLoadingMethods.value = false;
    }
  }

  void selectMethod(PaymentMethodModel method) {
    selectedMethod.value = method;
  }

  Future<void> pickReceiptImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) {
      receiptImage.value = File(picked.path);
      receiptImageName.value = picked.name;
    }
  }

  Future<void> pickFromCamera() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (picked != null) {
      receiptImage.value = File(picked.path);
      receiptImageName.value = picked.name;
    }
  }

  void removeImage() {
    receiptImage.value = null;
    receiptImageName.value = '';
  }

  Future<bool> submitPayment({required int orderId}) async {
    if (selectedMethod.value == null) {
      CustomSnackbar.warning('يرجى اختيار طريقة الدفع'.tr);
      return false;
    }
    if (receiptImage.value == null) {
      CustomSnackbar.warning('يرجى إرفاق صورة الإيصال'.tr);
      return false;
    }

    isSubmitting.value = true;
    try {
      final formData = FormData.fromMap({
        'payment_method_id': selectedMethod.value!.id,
        'pay_image': await MultipartFile.fromFile(
          receiptImage.value!.path,
          filename: receiptImageName.value,
        ),
      });

      final response = await DioHelper.postForm(
        url: '${EndPoints.orders}/$orderId/pay',
        data: formData,
        sendAuthToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  void resetState() {
    selectedMethod.value = paymentMethods.isNotEmpty ? paymentMethods.first : null;
    receiptImage.value = null;
    receiptImageName.value = '';
  }
}
