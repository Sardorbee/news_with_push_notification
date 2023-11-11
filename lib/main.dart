import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_with_push_notification/bloc/notification_send/notification_bloc.dart';
import 'package:news_with_push_notification/cubit/subscription/subscription_cubit.dart';
import 'package:news_with_push_notification/cubit/tab_cubit/tab_cubit.dart';
import 'package:news_with_push_notification/services/network/api.dart';
import 'package:news_with_push_notification/services/notification/fcm.dart';
import 'package:news_with_push_notification/services/notification/local_notification.dart';
import 'package:news_with_push_notification/services/repository/notification_repository.dart';
import 'package:news_with_push_notification/ui/tab_bar/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NotificationRepository(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NotificationBloc(
              notificationRepository: context.read<NotificationRepository>(),
            )..add(
                FetchLocalNotification(),
              ),
          ),
          BlocProvider(
            create: (context) => TabCubit(),
          ),
          BlocProvider(
            create: (context) => SubscriptionCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    LocalNotificationService.localNotificationService.init(
      navigatorKey,
    );

    return MaterialApp(
      home: TabBarScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
