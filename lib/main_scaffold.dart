import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slow_your_roll/riverpod_widgets.dart';
import 'package:slow_your_roll/slow_your_roll_user.dart';
import 'profile_screen.dart';
import 'content_screen.dart';
import 'home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//
// class MainScaffold extends ConsumerStatefulWidget {
//   const MainScaffold({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   ConsumerState createState() => _MainScaffoldState();
// }
//
// class _MainScaffoldState extends ConsumerState<MainScaffold> {
//   int _selectedIndex = 0;
//
//   List<Widget> bodyScreens = [
//     HomeScreen(currentUser: SlowYourRollUser(),),
//     const ContentScreenConsumer(),
//     const ProfileScreen()
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final userStream = ref.watch(userSnapshotProvider);
//     return userStream.when(
//         data: (value) {
//           final uid = value!.id;
//           final currentUser = SlowYourRollUser.fromSnapshot(uid, value);
//           bodyScreens = [
//             HomeScreen(currentUser: currentUser),
//             ContentScreenConsumer(),
//             ProfileScreen(),
//           ];
//           return Scaffold(
//             extendBody: true,
//             bottomNavigationBar: BottomNavigationBar(
//               unselectedFontSize: 12.0,
//               selectedFontSize: 12.0,
//               currentIndex: _selectedIndex,
//               onTap: (newIndex) {
//                 setState(() {
//                   _selectedIndex = newIndex;
//                 });
//               },
//               items: const [
//                 BottomNavigationBarItem(
//                     label: 'Home',
//                     icon: Icon(Icons.home)),
//                 BottomNavigationBarItem(
//                     label: 'Content',
//                     icon: Icon(Icons.list)),
//                 BottomNavigationBarItem(
//                     label: 'Profile',
//                     icon: Icon(Icons.person)),
//               ],
//             ),
//             body: bodyScreens[_selectedIndex],
//           );
//         },
//         error: (_, __) => const RiverpodError(screenName: 'Home Screen'),
//         loading: () => const RiverpodLoading()
//     );
//   }
// }

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {

  int _selectedIndex = 0;

  final bodyScreens = [
    const HomeScreen(),
    const ContentScreenConsumer(),
    const ProfileScreen()
  ];
  //
  // getUser() async {
  //   final uid = FirebaseAuth.instance.currentUser?.uid;
  //
  //   final path = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //   final newUser = SlowYourRollUser.fromSnapshot(path);
  // }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 12.0,
        selectedFontSize: 12.0,
        currentIndex: _selectedIndex,
        onTap: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'Content',
              icon: Icon(Icons.list)),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person)),
        ],
      ),
      body: bodyScreens[_selectedIndex],
    );
  }
}



