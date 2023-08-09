import 'package:flutter/material.dart';
import 'package:news_with_push_notification/provider/news_provider.dart';
import 'package:provider/provider.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');
    return Consumer<NewsProvider>(
      builder: (context, NewsProvider, _) {
        return Scaffold(
          body: IndexedStack(
            index: NewsProvider.currentIndex,
            children: NewsProvider.screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: NewsProvider.currentIndex,
            onTap: (index) {
              NewsProvider.updateTabBarsIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
