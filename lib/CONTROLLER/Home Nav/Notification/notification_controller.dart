import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

enum NotificationType { pending, processing, shipped, delivered, cancelled }

class NotificationsController extends GetxController {
  List<NotificationsModel> notifications = [];
  bool isLoading = false;
  int currentPage = 1;
  int lastPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currentPage = 1;
        notifications.clear();
      }

      if (currentPage > lastPage) return;

      isLoading = true;
      update();

      final response = await DioHelper.getData(
        url: EndPoints.notifications,
        query: {'page': currentPage},
        sendAuthToken: true,
      );

      if (response.statusCode == 200) {
        final data = response.data['notifications'];

        lastPage = data['last_page'];

        final List fetched = data['data'];
        notifications.addAll(fetched.map((e) => NotificationsModel.fromJson(e)).toList());

        currentPage++;
      }
    } catch (e) {
      printLog('fetchNotifications error: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> refreshNotifications() => fetchNotifications(isRefresh: true);

  void markAsRead(int index) {
    notifications[index] = NotificationsModel(
      id: notifications[index].id,
      title: notifications[index].title,
      body: notifications[index].body,
      time: notifications[index].time,
      type: notifications[index].type,
      isRead: true,
    );
    update();
  }

  void clearAll() {
    notifications.clear();
    update();
  }
}
