import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_with_push_notification/cubit/subscription/subscription_cubit.dart';
import 'package:news_with_push_notification/services/local/sql_database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    print('build');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
      ),
      body: BlocBuilder<SubscriptionCubit, SubscriptionCheck>(
        builder: (context, state) {
          SubscriptionCubit subscribe = context.read<SubscriptionCubit>();

          return Column(
            children: [
              ListTile(
                title: const Text("News"),
                trailing: Switch(
                  value: state.newsTopic,
                  onChanged: (value) {
                    _databaseHelper.updateTopicPreference("News", value);
                    subscribe.getNewsTopic();

                    subscribe.newsTopicSubscription();
                  },
                ),
              ),
              ListTile(
                title: const Text("Technology"),
                trailing: Switch(
                  value: state.technologyTopic,
                  onChanged: (value) {
                    _databaseHelper.updateTopicPreference("Technology", value);
                    subscribe.getTechnologyTopic();

                    subscribe.technologyTopicSubscription();
                  },
                ),
              ),
              ListTile(
                title: const Text("Medicine"),
                trailing: Switch(
                  value: state.medicineTopic,
                  onChanged: (value) {
                    _databaseHelper.updateTopicPreference("Medicine", value);
                    subscribe.medicineTopicSubscription();
                    subscribe.getMedicineTopic();
                  },
                ),
              ),
              ListTile(
                title: const Text("Cars"),
                trailing: Switch(
                  value: state.carsTopic,
                  onChanged: (value) {
                    _databaseHelper.updateTopicPreference("Cars", value);
                    subscribe.getCarsTopic();

                    subscribe.carsTopicSubscription();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
