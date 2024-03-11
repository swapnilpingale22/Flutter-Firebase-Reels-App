import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_unlimited/screens/home/home_screen.dart';
import 'package:fun_unlimited/screens/home/profile_screen.dart';
import 'package:fun_unlimited/screens/reels/reels_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = "/bottom-bar";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 1;

  List<Widget> pages = const [
    HomeScreen(),
    ReelsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 'Hello User!',
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //               Text(
      //                 'Welcome to Fun Unlimited',
      //                 style: TextStyle(
      //                   fontSize: 14,
      //                   color: Colors.black26,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Text(
      //             'FU',
      //             style: TextStyle(
      //               fontSize: 40,
      //               color: Colors.blue,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        iconSize: 20,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.video_camera),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
