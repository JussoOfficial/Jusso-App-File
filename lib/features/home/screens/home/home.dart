import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/home/screens/internal%20screens/following.dart';
import 'package:jusso_2024_file/features/home/screens/internal%20screens/for_you.dart';
import 'package:jusso_2024_file/features/home/screens/internal%20screens/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  late Widget _currentScreen =
      const ForYouPage(); // Initialize with default screen
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _selectedIndex =
        _prefs.getInt('selectedIndex') ?? 2; // Set initial index to 2 (For You)
    _updateScreen();
  }

  void _updateScreen() {
    setState(() {
      _currentScreen =
          _selectedIndex == 1 ? FollowingPage() : const ForYouPage();
    });
  }

  void _saveSelectedIndex(int index) {
    _prefs.setInt('selectedIndex', index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                      _saveSelectedIndex(_selectedIndex);
                      _updateScreen();
                    });
                  },
                  child: Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color:
                          _selectedIndex == 1 ? Colors.deepOrange : Colors.grey,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                      _saveSelectedIndex(_selectedIndex);
                      _updateScreen();
                    });
                  },
                  child: Text(
                    'For You',
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color:
                          _selectedIndex == 2 ? Colors.deepOrange : Colors.grey,
                    ),
                  ),
                ),
                // Add search icon
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          // Display the current screen
          Expanded(
            child: _currentScreen,
          ),
        ],
      ),
    );
  }
}
