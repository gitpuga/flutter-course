import 'package:flutter/material.dart';
import 'package:task_7/components/service_card.dart';
import 'package:task_7/models/service.dart';

class MainPage extends StatelessWidget {
  final List<Service> items;
  final Function(Service) onAddToCart;

  const MainPage({super.key, required this.items, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Каталог услуг',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ServiceCard(product: items[index], onAddToCart: onAddToCart);
        },
      ),
    );
  }
}
