import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async'; // Import the dart:async library
import '../../models/motivation_today.dart';
import '../../services/motivation_today_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MotivationService motivationService = MotivationService();
  late Motivation _motivation;

  @override
  void initState() {
    super.initState();
    _motivation = Motivation(content: 'Loading...', author: 'Author');
    _loadMotivation();

    // Schedule the timer to check for new motivation at midnight
    _scheduleMidnightTimer();
  }

  void _loadMotivation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String storedDate = prefs.getString('motivation_date') ?? '';
    final String currentDate = DateTime.now().toString().split(' ')[0];

    if (storedDate != currentDate) {
      // Fetch a new motivation if it's a new day
      final Motivation newMotivation = await motivationService.fetchMotivationOfTheDay();
      setState(() {
        _motivation = newMotivation;
      });

      // Save the new motivation along with the current date
      prefs.setString('motivation_content', newMotivation.content);
      prefs.setString('motivation_author', newMotivation.author);
      prefs.setString('motivation_date', currentDate);
    } else {
      // Use the stored motivation if it's the same day
      setState(() {
        _motivation = Motivation(
          content: prefs.getString('motivation_content') ?? 'Loading...',
          author: prefs.getString('motivation_author') ?? 'Author',
        );
      });
    }
  }

  void _scheduleMidnightTimer() {
    // Calculate the duration until midnight
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = midnight.difference(now);

    // Schedule a timer to check for new motivation at midnight
    Timer.periodic(durationUntilMidnight, (Timer timer) {
      _loadMotivation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Motivation Today',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,),
                      ),
                    
                    Text(
                      _motivation.content,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '- ${_motivation.author}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
