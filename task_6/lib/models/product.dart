class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String imgUrl;
  final int price;
  final int? oldPrice;
  bool isFavorite;

  Product(this.id, this.title, this.description, this.category, this.price,
      this.oldPrice, this.imgUrl, this.isFavorite);
}
