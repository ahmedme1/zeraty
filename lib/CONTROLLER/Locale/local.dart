import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';

class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar': {'اللغة': 'اللغة', 'عربي': 'عربي', 'English': 'English'},
    'en': {'اللغة': 'Language', 'عربي': 'Arabic', 'English': 'English'},
  };
}
