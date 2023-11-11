import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:news_with_push_notification/services/local/sql_database.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionCheck> {
  SubscriptionCubit() : super(SubscriptionCheck()) {
    getNewsTopic();
    getMedicineTopic();
    getTechnologyTopic();
    getCarsTopic();
    Future.delayed(
      const Duration(
        days: 3,
      ),
    ).then(
      (value) => subscribeAll(),
    );
  }

  void getNewsTopic() async {
    bool newsTopic = await DatabaseHelper.instance.getTopicPreference("News");
    emit(state.copyWith(newsTopic: newsTopic));
  }

  void getTechnologyTopic() async {
    bool technologyTopic =
        await DatabaseHelper.instance.getTopicPreference("Technology");
    emit(state.copyWith(technologyTopic: technologyTopic));
  }

  void getMedicineTopic() async {
    bool medicineTopic =
        await DatabaseHelper.instance.getTopicPreference("Medicine");
    emit(state.copyWith(medicineTopic: medicineTopic));
  }

  void getCarsTopic() async {
    bool carsTopic = await DatabaseHelper.instance.getTopicPreference("Cars");
    emit(state.copyWith(carsTopic: carsTopic));
  }

// ___________________________________________________________________________
  // Subscription
  Future<void> subscribeAll() async {
    await FirebaseMessaging.instance.subscribeToTopic("News");
    await DatabaseHelper.instance.updateTopicPreference("News", true);
    bool newsTopic = await DatabaseHelper.instance.getTopicPreference("News");

    await FirebaseMessaging.instance.subscribeToTopic("Technology");

    await DatabaseHelper.instance.updateTopicPreference("Technology", true);
    bool technologyTopic =
        await DatabaseHelper.instance.getTopicPreference("Technology");
    await FirebaseMessaging.instance.subscribeToTopic("Medicine");

    await DatabaseHelper.instance.updateTopicPreference("Medicine", true);
    bool medicineTopic =
        await DatabaseHelper.instance.getTopicPreference("Medicine");
    await FirebaseMessaging.instance.subscribeToTopic('Cars');
    await DatabaseHelper.instance.updateTopicPreference("Cars", true);
    bool carsTopic = await DatabaseHelper.instance.getTopicPreference("Cars");
    emit(
      state.copyWith(
        newsTopic: newsTopic,
        technologyTopic: technologyTopic,
        medicineTopic: medicineTopic,
        carsTopic: carsTopic,
      ),
    );
  }

  Future<void> newsTopicSubscription() async {
    if (!state.newsTopic) {
      print(state.newsTopic);

      await FirebaseMessaging.instance.subscribeToTopic("News");
      print("subscribed to news");
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic("News");
      print("unsubscribed to news");
    }
  }

  Future<void> technologyTopicSubscription() async {
    if (!state.technologyTopic) {
      print(state.technologyTopic);
      await FirebaseMessaging.instance.subscribeToTopic("Technology");
      print("subscribed to news");
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic("Technology");
      print("unsubscribed to news");
    }
  }

  Future<void> medicineTopicSubscription() async {
    if (!state.medicineTopic) {
      await FirebaseMessaging.instance.subscribeToTopic("Medicine");
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic("Medicine");
    }
  }

  Future<void> carsTopicSubscription() async {
    if (!state.carsTopic) {
      await FirebaseMessaging.instance.subscribeToTopic('Cars');
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic("Cars");
    }
  }
}
