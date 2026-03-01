import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

class MyLocalController extends GetxController {
  Locale? language = CacheKeysManger.getLanguageFromCache().isEmpty
      ? const Locale(ar)
      : Locale(CacheKeysManger.getLanguageFromCache());
  void changeLang(String codelang) {
    Locale locale = Locale(codelang);
    CacheHelper.saveData(key: lang, value: codelang);
    Get.updateLocale(locale);
  }
}
