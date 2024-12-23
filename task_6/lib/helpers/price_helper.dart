import 'package:intl/intl.dart';

String formatPrice(int? price) {
  final formatter = NumberFormat('#,###', 'ru_RU');
  return formatter.format(price);
}
