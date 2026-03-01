import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

class MainController extends GetxController {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  var language = CacheHelper.getData(key: 'lang');
  checkLanguage() {
    if (language == null) {
      CacheHelper.saveData(key: "lang", value: 'ar');
    }
  }

  @override
  void onInit() {
    checkLanguage();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    super.onInit();
  }
}
