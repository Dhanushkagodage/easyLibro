class Resource {
  final String isbn;
  final String title;
  final int noOfBooks;
  final String url;
  final String type;
  final String author;
  final int remain;
  final String location;
  final DateTime dateadded;
  final int noOfRes;

  const Resource({
    required this.isbn,
    required this.title,
    required this.noOfBooks,
    required this.url,
    required this.type,
    required this.author,
    required this.remain,
    required this.location,
    required this.dateadded,
    required this.noOfRes,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      isbn: json['isbn'] ?? '',
      title: json['title'] ?? '',
      noOfBooks: (json['noOfBooks'] ?? 0) as int,
      url: json['url'] ?? '',
      type: json['type'] ?? '',
      author: json['author'] ?? '',
      remain: (json['remain'] ?? 0) as int,
      location: json['location'] ?? '',
      dateadded: DateTime.parse(json['dateadded'] ?? ''),
      noOfRes: (json['noOfRes'] ?? 0) as int,
    );
  }
}
