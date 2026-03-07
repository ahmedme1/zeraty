import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class LoginController extends GetxController {
  var obscureText = true.obs;
  var isLoading = false.obs;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  toggleShowPassword() {
    obscureText.value = !obscureText.value;
  }

  login() async {
    isLoading.value = true;
    try {
      String? fcmToken;

      try {
        fcmToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        log('FCM ERROR: $e');
        fcmToken = 'AAA';
      }
      final response = await DioHelper.postData(
        url: EndPoints.login,
        data: {
          "identifier": phoneController.text.trim(),
          "password": passwordController.text.trim(),
          "fcm_token": fcmToken,
        },
      );

      final message = response.data["message"];
      isLoading.value = false;
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = response.data["data"]["user"];
        final userToken = response.data["data"]["token"];

        CacheHelper.saveData(key: userName, value: user["name"] ?? '');
        CacheHelper.saveData(key: userEmail, value: user["email"] ?? '');
        CacheHelper.saveData(key: userPhone, value: user["phone"] ?? 0);
        CacheHelper.saveData(key: token, value: userToken);
        CacheHelper.saveData(key: guestSession, value: false);
        Get.offAll(() => HomeNavScreen());
      } else {
        CustomSnackbar.warning(message.toString());
      }
    } on DioException catch (error) {
      printLog(error.toString());
    } catch (error) {
      printLog(error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void validationDateAndLogin() {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final egyptPhone = RegExp(r'^(010|011|012|015)[0-9]{8}$');

    if (phone.isEmpty) {
      CustomSnackbar.warning('برجاء كتابة رقم الهاتف'.tr);
    } else if (!egyptPhone.hasMatch(phone)) {
      CustomSnackbar.warning('اكتب رقم الهاتف بشكل صحيح'.tr);
    } else if (password.isEmpty) {
      CustomSnackbar.warning('برجاء كتابة كلمة المرور'.tr);
    } else if (password.length < 8) {
      CustomSnackbar.warning('يجب ألا تقل كلمة المرور عن 8 أحرف أو أرقام'.tr);
    } else {
      login();
    }
  }
}
