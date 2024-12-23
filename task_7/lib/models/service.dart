class Service {
  final String title;
  final String description;
  final int price;
  final String time;
  int? quantity;

  Service({
    required this.title,
    required this.description,
    required this.price,
    required this.time,
    this.quantity = 1,
  });
}
