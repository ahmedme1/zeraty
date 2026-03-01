import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

@pragma('vm:entry-point')
class NotificationHandlerController {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    Get.to(() => const NotificationScreen());
  }

  @pragma("vm:entry-point")
  static Future<void> onBackgroundNoti(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    final title = notification?.title ?? data['title'] ?? 'إشعار جديد';
    final body = notification?.body ?? data['body'] ?? '';

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: appChannelName,
        title: title,
        body: body,
        category: NotificationCategory.Message,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: ColorsApp.primaryGreenColor,
        payload: data.isNotEmpty ? Map<String, String>.from(data) : null,
      ),
    );
  }

  @pragma("vm:entry-point")
  static Future<void> onForgroundNoti(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    final title = notification?.title ?? data['title'] ?? 'إشعار جديد';
    final body = notification?.body ?? data['body'] ?? '';

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: appChannelName,
        title: title,
        body: body,
        category: NotificationCategory.Message,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: ColorsApp.primaryGreenColor,
        payload: data.isNotEmpty ? Map<String, String>.from(data) : null,
      ),
    );
  }
}
