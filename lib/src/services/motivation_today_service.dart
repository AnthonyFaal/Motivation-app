import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/motivation_today.dart';

class MotivationService {
  static const String apiUrl = 'https://api.quotable.io/quotes/random';

  Future<Motivation> fetchMotivationOfTheDay() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      if (jsonList.isNotEmpty) {
        // Assuming you want to pick the first item in the list
        final Map<String, dynamic> jsonMap = jsonList[0];
        return Motivation.fromJson(jsonMap);
      } else {
        throw Exception('No motivation found in the response');
      }
    } else {
      throw Exception('Failed to load motivation');
    }
  }
}
