import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/QuotesModel.dart';

class QuoteService {
  static const String apiUrl = 'https://api.quotable.io/quotes/random?limit=100';

  Future<List<Quote>> fetchQuotes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Quote.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}
