import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:news_with_push_notification/services/local/sqsl_database.dart';
import 'package:news_with_push_notification/services/models/fcm_response_model.dart';
import 'package:news_with_push_notification/services/notification/local_notification.dart';

Future<void> initFirebase() async {
  await Firebase.initializeApp();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM USER TOKEN: $fcmToken");
  await FirebaseMessaging.instance.subscribeToTopic("News");

  // FOREGROUND MESSAGE HANDLING.
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint(
        "NOTIFICATION FOREGROUND MODE: ${message.notification!.title} in foreground");
    // LocalNotificationService.instance.showFlutterNotification(message);
    FcmResponseModel news = FcmResponseModel.fromJson(message.data);
    LocalNotificationService.localNotificationService
        .showRemoteNotification(message);
    print(news.newsID);

    DatabaseHelper.instance.insertProduct(
      FcmResponseModel(
        author: news.author,
        newsID: news.newsID,
        title: news.title,
        description: news.description,
        imageUrl: news.imageUrl,
        publishedAt: news.publishedAt,
        content: news.content,
      ),
    );
  });

  // BACkGROUND MESSAGE HANDLING
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FROM TERMINATED MODE

  handleMessage(RemoteMessage message) {
    debugPrint(
        "NOTIFICATION FROM TERMINATED MODE: ${message.notification!.title} in terminated");
    // LocalNotificationService.instance.showFlutterNotification(message);
    LocalNotificationService.localNotificationService
        .showRemoteNotification(message);
    FcmResponseModel news = FcmResponseModel.fromJson(message.data);
    DatabaseHelper.instance.insertProduct(
      FcmResponseModel(
        author: news.author,
        newsID: DateTime.now().toString(),
        title: news.title,
        description: news.description,
        imageUrl: news.imageUrl,
        publishedAt: news.publishedAt,
        content: news.content,
      ),
    );
  }

  RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (remoteMessage != null) {
    handleMessage(remoteMessage);
  }

  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  LocalNotificationService.localNotificationService
      .showRemoteNotification(message);
  FcmResponseModel news = FcmResponseModel.fromJson(message.data);
  DatabaseHelper.instance.insertProduct(
    FcmResponseModel(
      author: news.author,
      newsID: DateTime.now().toString(),
      title: news.title,
      description: news.description,
      imageUrl: news.imageUrl,
      publishedAt: news.publishedAt,
      content: news.content,
    ),
  );
  

  debugPrint(
      "NOTIFICATION BACKGROUND MODE: ${message.notification!.title} in background");
}
