import 'package:flutter/material.dart';
import 'package:messenger_app/pages/audio_page.dart';
import 'package:messenger_app/pages/home_page.dart';
import 'package:messenger_app/pages/profile_page.dart';
import 'package:messenger_app/pages/video_page.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _currentIndex = 0;

  // List of pages to be displayed in the bottom navigation bar
  final List<Widget> _pages = [
    // Replace these with your actual pages
    const HomePage(),
    const AudioPage(),
    const VideoPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Video Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Audio Call',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile')
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
