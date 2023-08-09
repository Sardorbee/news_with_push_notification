import 'package:flutter/material.dart';
import 'package:news_with_push_notification/provider/news_provider.dart';
import 'package:news_with_push_notification/services/local/sqsl_database.dart';
import 'package:provider/provider.dart';

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
      body: Column(
        children: [
          ListTile(
            title: const Text("News"),
            trailing: Consumer<NewsProvider>(
              builder: (context, xxx, child) {
                xxx.getNewsTopic();

                return Switch(
                  value: xxx.newsTopic,
                  onChanged: (value) {
                    _databaseHelper.updateTopicPreference("News", value);
                    xxx.newsTopicSubscription();
                  },
                );
              },
            ),
          ),
          ListTile(
            title: const Text("Technology"),
            trailing: Consumer<NewsProvider>(
              builder: (context, x, child) {
                x.gettechnologyTopic();

                return Switch(
                  value: x.technologyTopic,
                  onChanged: (value) {
                    _databaseHelper.updateTopicPreference("Technology", value);
                    x.technologyTopicSubscription();
                  },
                );
              },
            ),
          ),
          ListTile(
            title: const Text("Medicine"),
            trailing: Consumer<NewsProvider>(
              builder: (context, y, child) {
                y.getmedicineTopic();

                return Switch(
                  value: y.medicineTopic,
                  onChanged: (value) {
                    _databaseHelper.updateTopicPreference("Medicine", value);
                    y.medicineTopicSubscription();
                  },
                );
              },
            ),
          ),
          ListTile(
            title: const Text("Cars"),
            trailing: Consumer<NewsProvider>(
              builder: (context, xx, child) {
                xx.getcarsTopic();

                return Switch(
                  value: xx.carsTopic,
                  onChanged: (value) {
                    _databaseHelper.updateTopicPreference("Cars", value);
                    xx.carsTopicSubscription();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
