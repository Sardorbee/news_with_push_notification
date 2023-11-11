import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_with_push_notification/bloc/notification_send/notification_bloc.dart';
import 'package:news_with_push_notification/services/models/fcm_response_model.dart';
import 'package:news_with_push_notification/ui/add_news/add_news.dart';
import 'package:news_with_push_notification/ui/home/details/details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Morning Star",
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<NotificationBloc>().add(FetchLocalNotification());
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: state.data!.length,
              itemBuilder: (BuildContext context, int index) {
                FcmResponseModel news = state.data![index];

                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(fcmResponseModel: news),
                      )),
                  onLongPress: () {
                    context
                        .read<NotificationBloc>()
                        .deleteNews(news.publishedAt);
                  },
                  leading:
                      InteractiveViewer(child: Image.network(news.imageUrl)),
                  title: Text(news.title),
                  subtitle: Text(news.author),
                );
              },
            );
          } else {
            return const Center(
              child: Text('You have no notifications yet'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNews(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
