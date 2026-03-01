import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class FavoriteController extends GetxController {
  final RxList<WishlistItemModel> wishlistItems = <WishlistItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<PaginationModel?> pagination = Rx<PaginationModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();
  }

  Future<void> fetchWishlist({int page = 1}) async {
    try {
      isLoading.value = true;

      final response = await DioHelper.getData(
        url: EndPoints.wishlist,
        query: {'page': page},
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200) {
        final wishlistResponse = WishlistResponse.fromJson(response.data);

        if (wishlistResponse.success) {
          wishlistItems.value = wishlistResponse.data;
          pagination.value = wishlistResponse.pagination;
        }
      }
    } catch (e) {
      printLog('Error fetching wishlist: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToWishlist(int productId) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.wishlist,
        data: {'product_id': productId},
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // CustomSnackbar.success('تم الإضافة للمفضلة');
        await fetchWishlist();
      }
    } catch (e) {
      printLog('Error adding to wishlist: $e');
      CustomSnackbar.error('فشل الإضافة للمفضلة');
    }
  }

  Future<void> removeFromWishlist(int wishlistId) async {
    try {
      final response = await DioHelper.deleteData(
        url: '${EndPoints.wishlist}/$wishlistId',
        sendAuthToken: true,
        showErrors: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomSnackbar.success('تم الحذف من المفضلة');
        wishlistItems.removeWhere((item) => item.id == wishlistId);
      }
    } catch (e) {
      printLog('Error removing from wishlist: $e');
      CustomSnackbar.error('فشل الحذف من المفضلة');
    }
  }

  bool isInWishlist(int productId) {
    return wishlistItems.any((item) => item.product.id == productId);
  }

  int? getWishlistId(int productId) {
    final item = wishlistItems.firstWhereOrNull((item) => item.product.id == productId);
    return item?.id;
  }

  Future<void> toggleFavorite(int productId) async {
    if (isInWishlist(productId)) {
      final wishlistId = getWishlistId(productId);
      if (wishlistId != null) {
        await removeFromWishlist(wishlistId);
      }
    } else {
      await addToWishlist(productId);
    }
  }
}
