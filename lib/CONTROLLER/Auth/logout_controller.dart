import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class LogoutController extends GetxController {
  var isLoading = false.obs;

  logout() async {
    isLoading.value = true;
    try {
      final response = await DioHelper.postData(url: EndPoints.logout, sendAuthToken: true);

      final message = response.data["message"];
      isLoading.value = false;
      if (response.statusCode == 200 || response.statusCode == 201) {
        removeUserData();
        Get.offAll(() => LoginScreen());
        CacheHelper.saveData(key: guestSession, value: true);
      } else {
        removeUserData();
        Get.offAll(() => LoginScreen());
        CacheHelper.saveData(key: guestSession, value: true);
        CustomSnackbar.warning(message.toString());
      }
    } on DioException catch (error) {
      removeUserData();
      Get.offAll(() => LoginScreen());
      CacheHelper.saveData(key: guestSession, value: true);
      printLog(error.toString());
    } catch (error) {
      removeUserData();
      Get.offAll(() => LoginScreen());
      CacheHelper.saveData(key: guestSession, value: true);
      printLog(error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
