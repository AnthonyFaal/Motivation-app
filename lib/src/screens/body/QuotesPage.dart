import 'package:flutter/material.dart';
import '../../models/QuotesModel.dart';
import '../../services/Quotes_service.dart';
import '../../services/share_quote.dart';

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late Future<List<Quote>> quotes;

  @override
  void initState() {
    super.initState();
    quotes = QuoteService().fetchQuotes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder<List<Quote>>(
        future: quotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No quotes available.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final Quote currentQuote = snapshot.data![index];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      ListTile(
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
                      ),
                       Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
                                QuoteShareHelper.shareQuote(currentQuote.content, currentQuote.author);}
                            ),
                            IconButton(
                              icon: Icon(
                                currentQuote.isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: currentQuote.isFavorite ? Colors.red : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  currentQuote.isFavorite = !currentQuote.isFavorite;
                                });
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
