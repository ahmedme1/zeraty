import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class AddressController extends GetxController {
  final RxList<AddressModel> addresses = <AddressModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.addresses,
        sendAuthToken: false,
        showErrors: false,
        silent: true,
      );

      if (response.statusCode == 200) {
        final addressesResponse = AddressesResponse.fromJson(response.data);

        if (addressesResponse.success) {
          addresses.value = addressesResponse.data;
        }
      }
    } catch (e) {
      printLog('Error fetching addresses: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
