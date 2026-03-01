import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class SearchControllers extends GetxController {
  final TextEditingController searchTextController = TextEditingController();

  String? selectedSearchMethod;
  final List<String> searchMethods = ['بحث بالاسم', 'بحث بالشركة', 'بحث بالفئة'];

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<int> selectedCategoryIds = <int>[].obs;

  final RxList<SearchProductModel> searchResults = <SearchProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<PaginationModel?> pagination = Rx<PaginationModel?>(null);

  @override
  void onInit() {
    super.onInit();
    selectedSearchMethod = searchMethods[0];
    fetchCategories();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.categories,
        sendAuthToken: false,
        showErrors: false,
        silent: true,
      );

      if (response.statusCode == 200) {
        final categoriesResponse = CategoriesResponse.fromJson(response.data);

        if (categoriesResponse.success) {
          categories.value = categoriesResponse.data;
        }
      }
    } catch (e) {
      printLog('Error fetching categories: $e');
    }
  }

  void updateSearchMethod(String? newValue) {
    selectedSearchMethod = newValue;
    update();
  }

  void toggleCategory(int categoryId) {
    if (selectedCategoryIds.contains(categoryId)) {
      selectedCategoryIds.remove(categoryId);
    } else {
      selectedCategoryIds.add(categoryId);
    }
    update();
  }

  Future<void> search({int page = 1}) async {
    if (searchTextController.text.isEmpty && selectedCategoryIds.isEmpty) {
      CustomSnackbar.warning('الرجاء إدخال نص البحث أو اختيار فئة');
      return;
    }

    try {
      isLoading.value = true;

      Map<String, dynamic> queryParams = {'page': page};

      if (selectedCategoryIds.isNotEmpty) {
        queryParams['category_ids'] = selectedCategoryIds.join(',');
      }

      if (searchTextController.text.isNotEmpty) {
        if (selectedSearchMethod == 'بحث بالشركة') {
          queryParams['company_name'] = searchTextController.text;
        } else {
          queryParams['name'] = searchTextController.text;
        }
      }

      final response = await DioHelper.getData(
        url: EndPoints.search,
        query: queryParams,
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final searchResponse = SearchResponse.fromJson(response.data);

        if (searchResponse.success) {
          searchResults.value = searchResponse.data;
          pagination.value = searchResponse.pagination;

          Get.to(() => SearchResultsScreen(), transition: Transition.fadeIn);
        }
      }
    } catch (e) {
      printLog('Error searching: $e');
      CustomSnackbar.error('حدث خطأ أثناء البحث');
    } finally {
      isLoading.value = false;
    }
  }
}
