import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class HomeController extends GetxController {
  final CarouselSliderController carouselController = CarouselSliderController();

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<PaginationModel?> pagination = Rx<PaginationModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories({int page = 1}) async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.categories,
        query: {'page': page},
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final categoriesResponse = CategoriesResponse.fromJson(response.data);

        if (categoriesResponse.success) {
          categories.value = categoriesResponse.data;
          pagination.value = categoriesResponse.pagination;
        }
      }
    } catch (e) {
      printLog('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  int getCrossAxisCount(int index) {
    if (index == 0) return 10;
    final adjustedIndex = index - 1;
    final rowIndex = adjustedIndex ~/ 2;
    final isFirstInRow = adjustedIndex % 2 == 0;
    if (rowIndex.isEven) {
      return isFirstInRow ? 6 : 4;
    } else {
      return isFirstInRow ? 4 : 6;
    }
  }
}
