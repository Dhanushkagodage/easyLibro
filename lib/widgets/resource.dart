class Resource {
  final String isbn;
  final String title;
  final String auther;
  final int quantity;
  final String imgURL;
  final String description;
  final int totalqty;
  final int borrowedqty;
  final String location;

  Resource(
      {required this.isbn,
      required this.title,
      required this.auther,
      required this.quantity,
      required this.imgURL,
      required this.description,
      required this.totalqty,
      required this.borrowedqty,
      required this.location});
}
