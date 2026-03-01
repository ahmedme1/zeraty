import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

enum SnackbarType { success, error, warning, info }

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    required SnackbarType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = Colors.green.shade600;
        textColor = Colors.white;
        icon = Icons.check_circle;
        break;
      case SnackbarType.error:
        backgroundColor = Colors.red.shade600;
        textColor = Colors.white;
        icon = Icons.error;
        break;
      case SnackbarType.warning:
        backgroundColor = Colors.orange.shade600;
        textColor = Colors.white;
        icon = Icons.warning;
        break;
      case SnackbarType.info:
        backgroundColor = Colors.blue.shade600;
        textColor = Colors.white;
        icon = Icons.info;
        break;
    }

    Get.snackbar(
      '',
      '',

      backgroundColor: backgroundColor,
      colorText: textColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: duration,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: Icon(icon, color: textColor),
      shouldIconPulse: true,
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      boxShadows: [
        BoxShadow(
          color: ColorsApp.withOpacity(Colors.black, 0.2),
          blurRadius: 10.r,
          spreadRadius: 2.r,
          offset: const Offset(0, 4),
        ),
      ],
      overlayBlur: 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      titleText: text(
        title: title,
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
        textAlign: TextAlign.start,
      ),
      messageText: text(
        title: message,
        color: ColorsApp.withOpacity(textColor, 0.9),
        fontSize: 14.sp,
        textAlign: TextAlign.start,
      ),
    );
  }

  static void success(String message, {Duration? duration}) {
    show(
      title: 'رائع'.tr,
      message: message,
      type: SnackbarType.success,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  static void error(String message, {Duration? duration}) {
    show(
      title: 'خطأ'.tr,
      message: message,
      type: SnackbarType.error,
      duration: duration ?? const Duration(seconds: 4),
    );
  }

  static void warning(String message, {Duration? duration}) {
    show(
      title: 'تنبيه'.tr,
      message: message,

      type: SnackbarType.warning,
      duration: duration ?? const Duration(seconds: 4),
    );
  }

  static void info(String message, {Duration? duration}) {
    show(
      title: 'معلومة'.tr,
      message: message,
      type: SnackbarType.info,
      duration: duration ?? const Duration(seconds: 3),
    );
  }
}
