import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_with_push_notification/constants/constants.dart';
import 'package:news_with_push_notification/services/models/all_response.dart';


class ApiProvider{
  
static Future<void> sendFCMNotification( AlldataFromnotify body) async {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };
  
  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification. Status code: ${response.statusCode}');
  }
}
}
