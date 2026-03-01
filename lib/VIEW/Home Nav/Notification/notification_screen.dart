import 'package:zeraytee/CONTROLLER/CONST/Imports/view.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/packages.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/controller.dart';
import 'package:zeraytee/CONTROLLER/CONST/Imports/model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      init: NotificationsController(),
      builder: (controller) {
        return CustomStatusBar(
          child: Scaffold(
            backgroundColor: ColorsApp.backgroundColor,
            appBar: CustomAppBar(title: 'الإشعارات', backButton: true),
            body: controller.isLoading && controller.notifications.isEmpty
                ? const NotificationsShimmer()
                : controller.notifications.isEmpty
                ? const EmptyNotifications()
                : RefreshIndicator(
                    onRefresh: controller.refreshNotifications,
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: controller.notifications.length + 1,
                      itemBuilder: (context, index) {
                        if (index == controller.notifications.length) {
                          if (controller.currentPage <= controller.lastPage) {
                            controller.fetchNotifications();
                            return const Center(child: CircularProgressIndicator());
                          }
                          return const SizedBox.shrink();
                        }
                        return NotificationCard(notification: controller.notifications[index]);
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationsModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationIcon(type: notification.type),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  title: notification.title,
                  color: Colors.black87,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 8.h),
                text(
                  title: notification.body,
                  color: Colors.grey.shade600,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.h),
                text(
                  title: DateFormat(
                    'dd MMM yyyy - hh:mm a',
                    'ar',
                  ).format(DateTime.parse(notification.time).toLocal()),
                  color: Colors.grey.shade400,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  final NotificationType type;

  const NotificationIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    IconData icon;
    Color iconColor;

    switch (type) {
      case NotificationType.pending:
        backgroundColor = Colors.orange.shade100;
        icon = Icons.hourglass_empty_outlined;
        iconColor = Colors.orange.shade600;
        break;
      case NotificationType.processing:
        backgroundColor = Colors.blue.shade100;
        icon = Icons.autorenew_outlined;
        iconColor = Colors.blue.shade600;
        break;
      case NotificationType.shipped:
        backgroundColor = Colors.purple.shade100;
        icon = Icons.local_shipping_outlined;
        iconColor = Colors.purple.shade600;
        break;
      case NotificationType.delivered:
        backgroundColor = Colors.green.shade100;
        icon = Icons.inventory_2_outlined;
        iconColor = Colors.green.shade600;
        break;
      case NotificationType.cancelled:
        backgroundColor = Colors.red.shade100;
        icon = Icons.cancel_outlined;
        iconColor = Colors.red.shade600;
        break;
    }

    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(16.r)),
      child: Icon(icon, color: iconColor, size: 24.sp),
    );
  }
}

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80.sp, color: Colors.grey.shade400),
          SizedBox(height: 16.h),
          text(
            title: 'لا توجد إشعارات',
            color: Colors.grey.shade600,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 8.h),
          text(
            title: 'سيتم إعلامك عند وجود أي تحديثات',
            color: Colors.grey.shade500,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }
}
