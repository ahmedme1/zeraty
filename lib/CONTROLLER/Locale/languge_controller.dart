import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

class LangugeController extends GetxController {
  MyLocalController controllerLang = Get.find();
  int selectedLanguageValue = CacheHelper.getData(key: selectedLanguage) ?? 0;

  changeLanguage({required String langCode}) {
    if (langCode == ar) {
      selectedLanguageValue = 0;
      CacheHelper.saveData(key: selectedLanguage, value: 0);
      controllerLang.changeLang(ar);
      CacheHelper.saveData(key: lang, value: ar);
      update();
    } else {
      selectedLanguageValue = 1;
      CacheHelper.saveData(key: selectedLanguage, value: 1);
      controllerLang.changeLang(en);
      CacheHelper.saveData(key: lang, value: en);
      update();
    }

    // Get.offAll(() => HomeNavScreen());
  }
}
