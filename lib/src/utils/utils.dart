
import '../models/QuotesModel.dart';

List<Quote> getFavoriteQuotes(List<Quote> quotes) {
  return quotes.where((quote) => quote.isFavorite).toList();
}
