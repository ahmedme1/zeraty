import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class PhoneController extends GetxController {
  final RxList<PhoneNumberModel> phoneNumbers = <PhoneNumberModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPhoneNumbers();
  }

  Future<void> fetchPhoneNumbers() async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.phoneNumbers,
        sendAuthToken: false,
        showErrors: false,
        silent: true,
      );

      if (response.statusCode == 200) {
        final phoneNumbersResponse = PhoneNumbersResponse.fromJson(response.data);

        if (phoneNumbersResponse.success) {
          phoneNumbers.value = phoneNumbersResponse.data;
        }
      }
    } catch (e) {
      printLog('Error fetching phone numbers: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
