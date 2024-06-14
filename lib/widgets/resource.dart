class Resource {
  final String isbn;
  final String title;
  final String author;
  final int noOfBooks;
  final String url;
  final String type;

  const Resource(
      {required this.isbn,
      required this.title,
      required this.author,
      required this.noOfBooks,
      required this.url,
      required this.type});

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
        isbn: json['isbn'] ?? '',
        title: json['title'] ?? '',
        author: json['author'] ?? '',
        noOfBooks: (json['quantity'] ?? 0) as int,
        url: json['url'] ?? '',
        type: json['type'] ?? '');
  }

  // Map<String, dynamic> toJson() => {
  //       'isbn': isbn,
  //       'title': title,
  //       'author': author,
  //       'quantity': noOfBooks,
  //       'url': url,
  //       'type': type
  //     };
}
