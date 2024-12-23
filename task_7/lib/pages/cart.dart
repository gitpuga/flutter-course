import 'package:flutter/material.dart';
import 'package:task_7/components/cart_item.dart';
import 'package:task_7/models/service.dart';

class CartPage extends StatelessWidget {
  final List<Service> items;
  final VoidCallback onCheckout;
  final Function(Service) removeFromCart;
  final Function(Service) onIncreaseQuantity;
  final Function(Service) onDecreaseQuantity;

  const CartPage({
    super.key,
    required this.items,
    required this.onCheckout,
    required this.removeFromCart,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = items.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity!),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Корзина',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CartItem(
                  item: items[index],
                  onRemove: () => removeFromCart(items[index]),
                  onIncreaseQuantity: () => onIncreaseQuantity(items[index]),
                  onDecreaseQuantity: () => onDecreaseQuantity(items[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Сумма',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '$totalPrice ₽',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(26, 111, 238, 1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Перейти к оформлению заказа',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
