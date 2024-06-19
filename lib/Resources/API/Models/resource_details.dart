class ResourceDetails {
  final String isbn;
  final String type;
  final String title;
  final String author;
  final int remain;
  final int borrowed;
  final int total;
  final String cupboardId;
  final String cupboardName;
  final String shelfId;
  final String description;
  final int pages;
  final int price;
  final DateTime addedon;
  final String imagepath;

  const ResourceDetails({
    required this.isbn,
    required this.type,
    required this.title,
    required this.author,
    required this.remain,
    required this.borrowed,
    required this.total,
    required this.cupboardId,
    required this.cupboardName,
    required this.shelfId,
    required this.description,
    required this.pages,
    required this.price,
    required this.addedon,
    required this.imagepath,
  });

  factory ResourceDetails.fromJson(Map<String, dynamic> json) {
    return ResourceDetails(
      isbn: json['isbn'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      remain: json['remain'] ?? 0,
      borrowed: json['borrowed'],
      total: json['total'],
      cupboardId: json['cupboardId'],
      cupboardName: json['cupboardName'],
      shelfId: json['shelfId'],
      description: json['description'],
      pages: json['pages'],
      price: json['price'],
      addedon: DateTime.parse(json['addedon']),
      imagepath: json['imagepath'], 
    );
  }
}
