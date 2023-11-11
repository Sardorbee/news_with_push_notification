import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_with_push_notification/constants/constants.dart';
import 'package:news_with_push_notification/services/models/all_response.dart';
import 'package:news_with_push_notification/services/models/universal.dart';

class ApiService {
  OpenApiService() {
    _init();
  }

  _init() {
    _dioOpen.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          //error.response.statusCode
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${requestOptions.path}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

  final _dioOpen = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'key=$serverKey',
      },
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  Future<void> sendNotification({AlldataFromnotify? body}) async {
    Response response;
    try {
      response = await _dioOpen.post(
        '/send',
        data: body,
      );
      print(response.data);

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      }
    } catch (error) {
      print('Failed to send notification. Status code: ${error.toString()}');
    }
  }

  // static Future<void> sendFCMNotification(AlldataFromnotify body) async {
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'key=$serverKey',
  //   };
  //
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: headers,
  //     body: jsonEncode(body),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print('Notification sent successfully');
  //   } else {
  //     print('Failed to send notification. Status code: ${response.statusCode}');
  //   }
  // }
}
