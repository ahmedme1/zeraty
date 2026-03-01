import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class RegisterController extends GetxController {
  var obscureText = true.obs;
  var obscureText2 = true.obs;
  var isLoading = false.obs;
  final RxnString selectedGovernorate = RxnString();
  final RxnString selectedCenter = RxnString();
  final RxList<String> governorates = <String>[].obs;
  final RxList<String> centers = <String>[].obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  toggleShowPassword() {
    obscureText.value = !obscureText.value;
  }

  toggleShowPasswordConfirmation() {
    obscureText2.value = !obscureText2.value;
  }

  register() async {
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
        url: EndPoints.register,
        data: {
          "name": nameController.text.trim(),
          "password": passwordController.text.trim(),
          "password_confirmation": passwordConfirmationController.text.trim(),
          "phone": phoneController.text.trim(),
          "city": selectedGovernorate.value,
          "state": selectedCenter.value,
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
        CacheHelper.saveData(key: guestSession, value: false);
        CacheHelper.saveData(key: token, value: userToken);
        Get.offAll(() => HomeNavScreen());
      } else if (response.statusCode == 422) {
        final errorMessage = extractErrors(response.data);
        CustomSnackbar.warning(errorMessage);
      } else {
        printLog(response.statusCode);
        printLog(response.data);
        CustomSnackbar.warning(message.toString());
      }
    } on DioException catch (error) {
      isLoading.value = false;
      if (error.response?.data != null) {
        final message = error.response?.data["message"] ?? 'حدث خطأ ما'.tr;
        CustomSnackbar.warning(message.toString());
      } else {
        CustomSnackbar.warning('حدث خطأ في الاتصال'.tr);
      }
      printLog(error.toString());
    } catch (error) {
      isLoading.value = false;
      CustomSnackbar.warning('حدث خطأ غير متوقع'.tr);
      printLog(error.toString());
    }
  }

  void validationDateAndRegister() {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = passwordConfirmationController.text.trim();

    if (name.isEmpty) {
      CustomSnackbar.warning('برجاء كتابة اسمك'.tr);
    } else if (phone.isEmpty) {
      CustomSnackbar.warning('برجاء كتابة رقم الهاتف'.tr);
    } else if (selectedGovernorate.value == null) {
      CustomSnackbar.warning('برجاء اختيار المحافظة'.tr);
    } else if (selectedCenter.value == null) {
      CustomSnackbar.warning('برجاء اختيار المركز'.tr);
    } else if (password.isEmpty) {
      CustomSnackbar.warning('برجاء كتابة كلمة المرور'.tr);
    } else if (password.length < 8) {
      CustomSnackbar.warning('يجب ألا تقل كلمة المرور عن 8 أحرف أو أرقام'.tr);
    } else if (password != confirmPassword) {
      CustomSnackbar.warning('كلمتا المرور غير متطابقين'.tr);
    } else {
      register();
    }
  }

  String extractErrors(dynamic response) {
    try {
      final errors = response?['errors'];

      if (errors is Map) {
        final messages = <String>[];

        errors.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            messages.add(value.first.toString());
          } else if (value != null) {
            messages.add(value.toString());
          }
        });

        if (messages.isNotEmpty) {
          return messages.join('\n');
        }
      }

      return response?['message']?.toString() ?? 'حدث خطأ غير متوقع';
    } catch (e) {
      return 'حدث خطأ غير متوقع';
    }
  }

  @override
  void onInit() {
    super.onInit();
    governorates.assignAll(egyptGovCenters.keys.toList()..sort());
  }

  void onGovernorateChanged(String? value) {
    selectedGovernorate.value = value;
    selectedCenter.value = null;

    if (value == null) {
      centers.clear();
      return;
    }

    final list = egyptGovCenters[value] ?? <String>[];
    centers.assignAll(list);
  }

  void onCenterChanged(String? value) {
    selectedCenter.value = value;
  }
}
