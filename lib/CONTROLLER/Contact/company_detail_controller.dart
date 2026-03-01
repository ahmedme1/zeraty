import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class CompanyDetailsController extends GetxController {
  final int companyId;

  final Rx<CompanyDetailsModel?> companyDetails = Rx<CompanyDetailsModel?>(null);
  final RxBool isLoading = false.obs;

  CompanyDetailsController({required this.companyId});

  @override
  void onInit() {
    super.onInit();
    fetchCompanyDetails();
  }

  Future<void> fetchCompanyDetails() async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: '${EndPoints.companies}/$companyId',
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final companyDetailsResponse = CompanyDetailsResponse.fromJson(response.data);

        if (companyDetailsResponse.success) {
          companyDetails.value = companyDetailsResponse.data;
        }
      }
    } catch (e) {
      printLog('Error fetching company details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
