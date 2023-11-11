// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:news_with_push_notification/services/local/sql_database.dart';
// import 'package:news_with_push_notification/services/models/all_response.dart';
// import 'package:news_with_push_notification/services/models/fcm_response_model.dart';
// import 'package:news_with_push_notification/services/models/notify_model.dart';
// import 'package:news_with_push_notification/services/models/universal.dart';
// import 'package:news_with_push_notification/services/network/api.dart';
// import 'package:news_with_push_notification/ui/home/home_screen.dart';
// import 'package:news_with_push_notification/ui/profile/profile_screen.dart';
// import 'package:news_with_push_notification/ui/ui_utils/loading_dialog.dart';
// import 'package:news_with_push_notification/ui/ui_utils/upload_service.dart';
//
// class NewsProvider with ChangeNotifier {
//   NewsProvider();
//
//   List<FcmResponseModel> _newsData = [];
//
//   List<FcmResponseModel> get newsData => _newsData;
//
//
//   TextEditingController titleController = TextEditingController();
//   TextEditingController authorController = TextEditingController();
//   TextEditingController contentController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   String imageUrl = '';
//   String selectedTopic = '';
//   int currentIndex = 0;
//   final List<Widget> screens = [
//     const HomeScreen(),
//     ProfileScreen(),
//   ];
//
//   tozalash() {
//     titleController.clear();
//     authorController.clear();
//     contentController.clear();
//     descriptionController.clear();
//     imageUrl = '';
//     selectedTopic = '';
//   }
//
//   void updateTabBarsIndex(int index) {
//     currentIndex = index;
//     notifyListeners();
//   }
//
//   void updateSelectedTopic(String topic) {
//     selectedTopic = topic;
//     notifyListeners();
//     print(topic);
//   }
//
//   Future<void> sendNotification() async {
//     if (titleController.text.isNotEmpty &&
//         authorController.text.isNotEmpty &&
//         contentController.text.isNotEmpty &&
//         descriptionController.text.isNotEmpty &&
//         imageUrl.isNotEmpty &&
//         selectedTopic.isNotEmpty) {
//       await ApiService.(
//         AlldataFromnotify(
//           to: "/topics/$selectedTopic",
//           notification:
//               NotifyModel(title: "Topic News", body: titleController.text),
//           fcmResponseModel: FcmResponseModel(
//             newsID: Random().nextInt(9999999).toString(),
//             author: authorController.text,
//             title: titleController.text,
//             description: descriptionController.text,
//             imageUrl: imageUrl,
//             publishedAt: DateTime.now().toString(),
//             content: contentController.text,
//           ),
//         ),
//       );
//     }
//   }
//
//   Future<void> uploadCategoryImage(
//     BuildContext context,
//     XFile xFile,
//   ) async {
//     showLoading(context: context);
//     UniversalData data = await ImageHandler.imageUploader(xFile);
//     if (context.mounted) {
//       hideLoading(dialogContext: context);
//     }
//     if (data.error.isEmpty) {
//       imageUrl = data.data as String;
//       notifyListeners();
//     } else {
//       if (context.mounted) {
//         showMessage(context, data.error);
//       }
//     }
//   }
//
//   showMessage(BuildContext context, String error) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
//     notifyListeners();
//   }
//
//
// }
