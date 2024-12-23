import 'package:flutter/material.dart';
import 'package:task_6/components/count_item.dart';
import '../models/cart_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BasketItem extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onTap;
  final ValueChanged<int> onCount;
  final VoidCallback deleteItem;

  const BasketItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.onCount,
    required this.deleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Slidable(
        direction: Axis.horizontal,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.5,
          children: [
            SlidableAction(
              onPressed: (context) {
                deleteItem();
              },
              backgroundColor: const Color.fromARGB(255, 163, 65, 58),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Удалить',
            ),
          ],
        ),
        key: ValueKey(item.id.toString()),
        child: ListTile(
          leading: Image.network(
            item.img,
            width: 70,
            fit: BoxFit.cover,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.title),
              Text(
                "${item.cost} ₽",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              CountItem(
                count: item.count,
                onIncreasePressed: () {
                  onCount(item.count + 1);
                },
                onDecreasePressed: () {
                  if (item.count == 1) {
                    deleteItem();
                  } else {
                    onCount(item.count - 1);
                  }
                },
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
