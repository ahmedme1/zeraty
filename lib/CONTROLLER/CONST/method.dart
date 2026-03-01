import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';

printLog(dynamic message) {
  return log(message.toString());
}

String getUserEmail() {
  return CacheKeysManger.getUserEmailFromCache();
}

String getUserName() {
  return CacheKeysManger.getUserNameFromCache();
}

String getUserPhone() {
  return CacheKeysManger.getUserPhoneNumberFromCache();
}

String getUserImage() {
  return CacheKeysManger.getUserImageFromCache();
}

String getToken() {
  return CacheKeysManger.getUserTokenFromCache();
}

bool isGuestSession() {
  return CacheKeysManger.isGuestSession();
}

removeUserData() {
  CacheHelper.removeData(key: lang);
  CacheHelper.removeData(key: token);
  CacheHelper.removeData(key: role);
  CacheHelper.removeData(key: selectedLanguage);
  CacheHelper.removeData(key: userImage);
  CacheHelper.removeData(key: userName);
  CacheHelper.removeData(key: userEmail);
  CacheHelper.removeData(key: userId);
  CacheHelper.removeData(key: userPhone);
}

final egyptPhoneInputFormatters = <TextInputFormatter>[
  FilteringTextInputFormatter.digitsOnly,
  LengthLimitingTextInputFormatter(11),
  TextInputFormatter.withFunction((oldValue, newValue) {
    final t = newValue.text;

    if (t.isEmpty) return newValue;

    if (t.length == 1) {
      if (t != '0') return oldValue;
      return newValue;
    }

    if (t.length == 2) {
      if (t != '01') return oldValue;
      return newValue;
    }

    if (t.length >= 3) {
      final third = t[2];
      if (!['0', '1', '2', '5'].contains(third)) return oldValue;
    }

    return newValue;
  }),
];
