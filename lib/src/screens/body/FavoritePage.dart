import 'package:flutter/material.dart';
import '../../models/QuotesModel.dart';

class FavoriteQuotesScreen extends StatelessWidget {
  final List<Quote> favoriteQuotes;

  FavoriteQuotesScreen({required this.favoriteQuotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Quotes'),
        backgroundColor: Colors.blue,
      ),
      body: favoriteQuotes.isEmpty
          ? Center(
              child: Text('No favorite quotes.'),
            )
          : ListView.builder(
              itemCount: favoriteQuotes.length,
              itemBuilder: (context, index) {
                final Quote currentQuote = favoriteQuotes[index];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      currentQuote.content,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '- ${currentQuote.author}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      // Handle tap on the quote if needed
                    },
                  ),
                );
              },
            ),
    );
  }
}
