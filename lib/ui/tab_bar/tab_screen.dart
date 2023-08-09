import 'package:firebase_storage/firebase_storage.dart';
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

// Future<void> clearAllPictures() async {
//   try {
//     Reference storageRef = FirebaseStorage.instance.ref('images/');
//     ListResult listResult = await storageRef.listAll();
//     for (Reference item in listResult.items) {
//       await item.delete();
//       print('Deleted file: ${item.fullPath}');
//     }
//     print('All pictures have been deleted from Firebase Storage.');
//   } catch (e) {
//     print('Error deleting pictures: $e');
//   }
// }
