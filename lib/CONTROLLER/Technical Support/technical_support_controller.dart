import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class TechnicalSupportController extends GetxController {
  final RxList<TechnicalSupportModel> engineers = <TechnicalSupportModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTechnicalSupport();
  }

  Future<void> fetchTechnicalSupport() async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.technicalSupport,
        sendAuthToken: false,
        showErrors: false,
        silent: true,
      );

      if (response.statusCode == 200) {
        final technicalSupportResponse = TechnicalSupportResponse.fromJson(response.data);

        if (technicalSupportResponse.success) {
          engineers.value = technicalSupportResponse.data;
        }
      }
    } catch (e) {
      printLog('Error fetching technical support: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> openWhatsApp(String phoneNumber) async {
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanNumber.startsWith('0')) {
      cleanNumber = '2${cleanNumber.substring(1)}';
    } else if (!cleanNumber.startsWith('2')) {
      cleanNumber = '2$cleanNumber';
    }

    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanNumber');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      CustomSnackbar.error('لا يمكن فتح الواتساب');
    }
  }
}
