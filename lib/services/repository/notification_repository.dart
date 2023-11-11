import 'package:news_with_push_notification/services/models/all_response.dart';
import 'package:news_with_push_notification/services/network/api.dart';

class NotificationRepository {
  final ApiService apiService;

  NotificationRepository({
    required this.apiService,
  });

  Future<void> sendNotification({required AlldataFromnotify body}) async => apiService.sendNotification(body:body );
}
