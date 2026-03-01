import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class BannerController extends GetxController {
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<PaginationModel?> pagination = Rx<PaginationModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  Future<void> fetchBanners({int page = 1}) async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.banners,
        query: {'page': page},
        sendAuthToken: false,
        showErrors: false,
        silent: true,
      );

      if (response.statusCode == 200) {
        final bannersResponse = BannersResponse.fromJson(response.data);

        if (bannersResponse.success) {
          banners.value = bannersResponse.data;
          pagination.value = bannersResponse.pagination;
        }
      }
    } catch (e) {
      printLog('Error fetching banners: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
