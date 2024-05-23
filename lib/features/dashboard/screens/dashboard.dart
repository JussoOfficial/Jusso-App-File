import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/home/screens/home/home.dart';
import 'package:jusso_2024_file/features/inbox/screens/messages/inbox.dart';
import 'package:jusso_2024_file/features/profile/screens/profile/profile.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class DashboardPage extends StatefulWidget {
  final int initialIndex;

  const DashboardPage({Key? key, required this.initialIndex}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const InboxScreen(),
    ProfileScreen(),
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
        backgroundColor: JColors.accentColor,
        selectedItemColor: JColors.primaryColor,
        unselectedItemColor: JColors.textColorTertiary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Inbox',
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
