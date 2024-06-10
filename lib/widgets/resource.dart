class Resource {
  final String isbn;
  final String title;
  final String author;
  final int quantity;
  final String imgURL;
  final String description;
  final int totalqty;
  final int borrowedqty;
  final String location;
  final String category;

  Resource(
      {required this.isbn,
      required this.title,
      required this.author,
      required this.quantity,
      required this.imgURL,
      required this.description,
      required this.totalqty,
      required this.borrowedqty,
      required this.location,
      required this.category});

}
