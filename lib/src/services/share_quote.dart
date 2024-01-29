import 'package:share/share.dart';

class QuoteShareHelper {
  static void shareQuote(String content, String author) {
    if (content != null && author != null) {
      final String message = '"$content" - $author';
      Share.share(message);
    }
  }
}
