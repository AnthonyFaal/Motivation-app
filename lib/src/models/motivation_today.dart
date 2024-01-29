class Motivation {
  final String content;
  final String author;

  Motivation({required this.content, required this.author});

  factory Motivation.fromJson(Map<String, dynamic> json) {
    return Motivation(
      content: json['content'] ?? '',
      author: json['author'] ?? '',
    );
  }
}
