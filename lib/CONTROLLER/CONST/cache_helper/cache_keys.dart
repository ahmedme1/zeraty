import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

class CacheKeysManger {
  static String getLanguageFromCache() => CacheHelper.getData(key: lang) ?? 'ar';
  static String getUserTokenFromCache() => CacheHelper.getData(key: token) ?? "";
  static String getUserRoleFromCache() => CacheHelper.getData(key: role) ?? "";
  static int getSelectedLanguage() => CacheHelper.getData(key: selectedLanguage) ?? 0;
  static String getUserImageFromCache() => CacheHelper.getData(key: userImage) ?? "";
  static String getUserNameFromCache() => CacheHelper.getData(key: userName) ?? "";
  static String getUserEmailFromCache() => CacheHelper.getData(key: userEmail) ?? "";
  static String getUserIDFromCache() => CacheHelper.getData(key: userId) ?? "";
  static String getUserPhoneNumberFromCache() => CacheHelper.getData(key: userPhone) ?? "";
  static bool isGuestSession() => CacheHelper.getData(key: guestSession) ?? false;
}
