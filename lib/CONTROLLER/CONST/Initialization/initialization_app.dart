import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';

class InitializationApp {
  static bool isDeviceEmulator = false;

  static Future<void> zerayteeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    isDeviceEmulator = await isEmulator();

    // ─── Permissions ─────────────────────────────────────────────
    await Permission.storage.request();
    await Permission.camera.request();
    if (!await AwesomeNotifications().isNotificationAllowed()) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    // ─── Core Initializations ────────────────────────────────────
    await Firebase.initializeApp();
    FirebaseMessaging.instance.requestPermission();

    await DioHelper.init();
    await CacheHelper.init();
    await initializeDateFormatting('ar', null);

    // ─── Orientation ─────────────────────────────────────────────
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // ─── Notification Channels ──────────────────────────────────
    AwesomeNotifications().initialize('resource://mipmap/ic_launcher', [
      NotificationChannel(
        channelKey: appChannelName,
        channelName: 'zeraytee Channel',
        channelDescription: 'Main Channel for zeraytee App',
        defaultColor: ColorsApp.secondaryBrownColor,
        ledColor: Colors.white,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'chat_channel',
        channelName: 'Zeraytee Chat Notifications',
        channelDescription: 'Notification channel for chat messages',
        defaultColor: ColorsApp.secondaryBrownColor,
        ledColor: Colors.white,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'progress_channel',
        channelName: 'Download Progress',
        channelDescription: 'Download progress notifications',
        defaultColor: ColorsApp.secondaryBrownColor,
        ledColor: Colors.white,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'completed_channel',
        channelName: 'Download Completed',
        channelDescription: 'Completed download notifications',
        defaultColor: ColorsApp.secondaryBrownColor,
        ledColor: Colors.white,
        channelShowBadge: true,
      ),
    ]);
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationHandlerController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationHandlerController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationHandlerController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationHandlerController.onDismissActionReceivedMethod,
    );

    // ─── Firebase Messaging ─────────────────────────────────────────────
    FirebaseMessaging.onBackgroundMessage(NotificationHandlerController.onBackgroundNoti);

    FirebaseMessaging.onMessage.listen(NotificationHandlerController.onForgroundNoti);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Get.to(() => const NotificationScreen());
    });
    // ─── Error Widget ────────────────────────────────────────────
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(
              title: 'في مشكلة حصلت , جرب تاني بعد شوية!',
              color: Colors.red,
              textAlign: TextAlign.center,
              fontSize: 14.sp,
            ),
          ],
        ),
      );
    };
  }
}
