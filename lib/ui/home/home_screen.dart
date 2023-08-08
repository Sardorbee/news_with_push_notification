import 'package:flutter/material.dart';
import 'package:news_with_push_notification/provider/news_provider.dart';
import 'package:news_with_push_notification/services/local/sqsl_database.dart';
import 'package:news_with_push_notification/services/models/fcm_response_model.dart';
import 'package:news_with_push_notification/ui/add_news/add_news.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Morning Star",
        ),
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, newsProvider, _) {
          newsProvider.fetchData();
          final newsData = newsProvider.newsData;

          if (newsData.isEmpty) {
            return const Center(child: Text('No results found'));
          }

          return ListView.builder(
            itemCount: newsData.length,
            itemBuilder: (BuildContext context, int index) {
              FcmResponseModel news = newsData[index];

              return ListTile(
                onLongPress: () {
                  Provider.of<ProductsProvider>(context, listen: false)
                      .deleteNews(news.publishedAt);
                },
                leading: Image.network(news.imageUrl),
                title: Text(news.title),
                subtitle: Text(news.author),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNews(
                  callback: () {
                    setState(() {});
                  },
                ),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}