import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_with_push_notification/cubit/tab_cubit/tab_cubit.dart';
import 'package:news_with_push_notification/ui/home/home_screen.dart';
import 'package:news_with_push_notification/ui/profile/profile_screen.dart';


class TabBarScreen extends StatelessWidget {
   TabBarScreen({super.key});


 final List<Widget> screens = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: context.watch<TabCubit>().state,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<TabCubit>().state,
        onTap: (index) {
          context.read<TabCubit>().changeTabIndex(index);
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
