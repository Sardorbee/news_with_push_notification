import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_with_push_notification/services/local/sql_database.dart';
import 'package:news_with_push_notification/services/models/all_response.dart';
import 'package:news_with_push_notification/services/models/fcm_response_model.dart';
import 'package:news_with_push_notification/services/models/notification_fields/notify_fields.dart';
import 'package:news_with_push_notification/services/models/notify_model.dart';
import 'package:news_with_push_notification/services/models/status.dart';
import 'package:news_with_push_notification/services/models/universal.dart';
import 'package:news_with_push_notification/services/repository/notification_repository.dart';
import 'package:news_with_push_notification/ui/ui_utils/loading_dialog.dart';
import 'package:news_with_push_notification/ui/ui_utils/upload_service.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required this.notificationRepository})
      : super(
          NotificationState(
            data: const [],
            allDataFromNotify: AlldataFromnotify(
              to: '',
              notification: NotifyModel(title: '', body: ''),
              fcmResponseModel: FcmResponseModel(
                author: '',
                title: '',
                description: '',
                imageUrl: '',
                publishedAt: DateTime.now().toString(),
                content: '',
              ),
            ),
          ),
        ) {
    on<SendNotification>(_sendNotification);
    on<FetchLocalNotification>(_fetchData);
  }
  final NotificationRepository notificationRepository;

  Future<void> _fetchData(
    FetchLocalNotification event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(data: await DatabaseHelper.instance.getAllnews()));
  }

  void deleteNews(String publishedAt) async {
    await DatabaseHelper.instance.deleteProduct(publishedAt);
    emit(state.copyWith(data: await DatabaseHelper.instance.getAllnews()));
  }

  updateWebsiteField({
    required NotificationFileds fieldKey,
    required dynamic value,
  }) {
    AlldataFromnotify currentData = state.allDataFromNotify;
    NotifyModel currentNotifyData = currentData.notification;
    FcmResponseModel currentFcmData = currentData.fcmResponseModel;

    switch (fieldKey) {
      case NotificationFileds.to:
        {
          currentData = currentData.copyWith(to: value as String);
          break;
        }
      case NotificationFileds.title:
        {
          currentNotifyData =
              currentNotifyData.copyWith(title: value as String);
          break;
        }
      case NotificationFileds.body:
        {
          currentNotifyData = currentNotifyData.copyWith(body: value as String);
          break;
        }
      case NotificationFileds.author:
        {
          currentFcmData = currentFcmData.copyWith(author: value as String);
          break;
        }
      case NotificationFileds.description:
        {
          currentFcmData =
              currentFcmData.copyWith(description: value as String);
          break;
        }
      case NotificationFileds.content:
        {
          currentFcmData = currentFcmData.copyWith(content: value as String);
          break;
        }
      case NotificationFileds.imageUrl:
        {
          currentFcmData = currentFcmData.copyWith(imageUrl: value as String);
          break;
        }
      case NotificationFileds.title2:
        {
          currentFcmData = currentFcmData.copyWith(title: value as String);
          break;
        }
    }

    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(
      allDataFromNotify: AlldataFromnotify(
          to: currentData.to,
          notification: currentNotifyData,
          fcmResponseModel: currentFcmData),
      status: FormStatus.pure,
    ));
  }

  Future<void> _sendNotification(
    SendNotification event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: "loading",
    ));

    await notificationRepository.sendNotification(
        body: state.allDataFromNotify);
    emit(state.copyWith(
      status: FormStatus.success,
      statusText: "Sent",
    ));
  }

  Future<void> uploadCategoryImage(
    BuildContext context,
    XFile xFile,
  ) async {
    showLoading(context: context);
    UniversalData data = await ImageHandler.imageUploader(xFile);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (data.error.isEmpty) {
      state.allDataFromNotify.fcmResponseModel.imageUrl = data.data as String;
      print(state.allDataFromNotify.fcmResponseModel.imageUrl);
    } else {}
  }
}
