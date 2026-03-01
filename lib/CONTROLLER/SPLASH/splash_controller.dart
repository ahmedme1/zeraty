import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class SplashController extends GetxController {
  final String roles = CacheKeysManger.getUserRoleFromCache();

  // ┌───────────────────────────────────────────────────────────────────────────┐
  // │                    Check User Type When Re-Open App                       │
  // └───────────────────────────────────────────────────────────────────────────┘

  Future<void> getUserInfo() async {
    final userToken = getToken();

    log('token is $userToken');

    if (userToken.isEmpty) {
      goToChooseType();
      return;
    } else {
      Get.offAll(() => HomeNavScreen(), transition: Transition.zoom);
    }
  }

  void goToChooseType() {
    Get.offAll(() => LoginScreen(), transition: Transition.zoom);
  }

  getToNextPage() {
    Timer(Duration(seconds: 3), () {
      getUserInfo();
    });
  }

  @override
  void onInit() {
    getToNextPage();

    super.onInit();
  }
}
