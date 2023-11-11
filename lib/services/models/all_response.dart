import 'package:news_with_push_notification/services/models/fcm_response_model.dart';
import 'package:news_with_push_notification/services/models/notify_model.dart';

class AlldataFromnotify {
    String to;
    NotifyModel notification;
    FcmResponseModel fcmResponseModel;

    AlldataFromnotify({
        required this.to,
        required this.notification,
        required this.fcmResponseModel,
    });

    AlldataFromnotify copyWith({
        String? to,
        NotifyModel? notification,
        FcmResponseModel? fcmResponseModel,
    }) {
        return AlldataFromnotify(
            to: to ?? this.to,
            notification: notification ?? this.notification,
            fcmResponseModel: fcmResponseModel ?? this.fcmResponseModel,
        );
    }

    factory AlldataFromnotify.fromJson(Map<String, dynamic> json) => AlldataFromnotify(
        to: json["to"],
        notification: NotifyModel.fromJson(json["notification"]),
        fcmResponseModel: FcmResponseModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "to": to,
        "notification": notification.toJson(),
        "data": fcmResponseModel.toJson(),
    };
}
