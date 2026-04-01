// lib/modules/notifications/controllers/notifications_controller.dart
import 'package:get/get.dart';
import '../../../../data/models/notification_model.dart';

class NotificationsController extends GetxController {
  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    // بيانات تجريبية (Mock Data)
    notifications.value = [
      NotificationModel(
        id: '1',
        title: 'newTripAssigned'.tr,
        body: 'tripToDamascusBody'.tr,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        type: NotificationType.trip,
      ),
      NotificationModel(
        id: '2',
        title: 'busMaintenance'.tr,
        body: 'maintenanceReminderBody'.tr,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: NotificationType.alert,
        isRead: true,
      ),
    ];
  }

  void markAsRead(int index) {
    notifications[index].isRead = true;
    notifications.refresh();
  }

  void clearAll() => notifications.clear();
}