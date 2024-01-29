import 'package:flutter/material.dart';

import 'body/FavoritePage.dart';
import 'body/QuotesPage.dart';
import 'body/audioScreen.dart';
import 'body/homePage.dart';



class MotivationalHomePage extends StatefulWidget {
  @override
  _MotivationalHomePageState createState() => _MotivationalHomePageState();
}

class _MotivationalHomePageState extends State<MotivationalHomePage> {
  int _currentIndex = 0;

  // Placeholder content for each tab
  final List<Widget> _tabs = [
    HomeScreen(),
    QuoteScreen(),
    AudioScreen(),
    FavoriteQuotesScreen(favoriteQuotes: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: 'home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Quotes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack),
            label: 'Audios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,color: Colors.red),
            label: 'favorite',

          ),
         
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class MotivationalScreen extends StatelessWidget {
  final int tabIndex;

  MotivationalScreen({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Motivational Content - Tab $tabIndex'),
    );
  }
}

class GoalsScreen extends StatelessWidget {
  final int tabIndex;

  GoalsScreen({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Goals - Tab $tabIndex'),
    );
  }
}

class CommunityScreen extends StatelessWidget {
  final int tabIndex;

  CommunityScreen({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Community - Tab $tabIndex'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final int tabIndex;

  ProfileScreen({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile - Tab $tabIndex'),
    );
  }
}
