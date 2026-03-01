import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class PartnerController extends GetxController {
  final RxList<CompanyModel> companies = <CompanyModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<PaginationModel?> pagination = Rx<PaginationModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }

  Future<void> fetchCompanies({int page = 1}) async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.companies,
        query: {'page': page},
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final companiesResponse = CompaniesResponse.fromJson(response.data);

        if (companiesResponse.success) {
          companies.value = companiesResponse.data;
          pagination.value = companiesResponse.pagination;
        }
      }
    } catch (e) {
      printLog('Error fetching companies: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
