class ResourceDetails {
  final String isbn;
  final String author;
  final int remain;
  final int borrowed;
  final int total;
  final String location;
  final String description;
  final int pages;
  final int price;
  final String addedon;
  final String type;
  final String title;
  final String url;

  const ResourceDetails({
    required this.isbn,
    required this.author,
    required this.remain,
    required this.borrowed,
    required this.total,
    required this.location,
    required this.description,
    required this.pages,
    required this.price,
    required this.addedon,
    required this.type,
    required this.title,
    required this.url,
  });

  factory ResourceDetails.fromJson(Map<String, dynamic> json) {
    return ResourceDetails(
      isbn: json['isbn'],
      author: json['author'],
      remain: json['remain'],
      borrowed: json['borrowed'],
      total: json['total'],
      location: json['location'],
      description: json['description'],
      pages: json['pages'],
      price: json['price'],
      addedon: json['addedon'],
      type: json['type'],
      title: json['title'],
      url: json['url'],
    );
  }  
}
