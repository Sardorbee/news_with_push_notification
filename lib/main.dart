import 'package:flutter/material.dart';
import 'package:news_with_push_notification/provider/news_provider.dart';
import 'package:news_with_push_notification/services/notification/fcm.dart';
import 'package:news_with_push_notification/services/notification/local_notification.dart';
import 'package:news_with_push_notification/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initFirebase();

  runApp(ChangeNotifierProvider(
    create: (context) => ProductsProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MaterialApp(
      home: const HomeScreen(),
      navigatorKey: navigatorKey,
    );
  }
}