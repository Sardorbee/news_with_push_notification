// To parse this JSON data, do
//
//     final fcmResponseModel = fcmResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:news_with_push_notification/services/models/fcm_response_model.dart';
import 'package:news_with_push_notification/services/models/notify_model.dart';

AlldataFromnotify fcmResponseModelFromJson(String str) => AlldataFromnotify.fromJson(json.decode(str));

String fcmResponseModelToJson(AlldataFromnotify data) => json.encode(data.toJson());

class AlldataFromnotify {
    String to;
    NotifyModel notification;
    FcmResponseModel fcmResponseModel;

    AlldataFromnotify({
        required this.to,
        required this.notification,
        required this.fcmResponseModel,
    });

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


