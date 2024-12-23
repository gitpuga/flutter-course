class CartItemModel {
  final int? id;
  final String title;
  final String description;
  final String img;
  final int cost;
  int count = 0;

  CartItemModel(
      this.id, this.title, this.description, this.img, this.cost, this.count);
}
