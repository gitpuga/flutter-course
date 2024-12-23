import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BasketBottom extends StatelessWidget {
  int price;
  int count;

  BasketBottom({super.key, required this.price, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Text("Всего товаров: $count",
                style: const TextStyle(
                  fontSize: 22,
                  color: Color.fromRGBO(0, 0, 0, 1),
                )),
            Text("Суммарно выходит на $price рублей",
                style: const TextStyle(
                  fontSize: 22,
                  color: Color.fromRGBO(0, 0, 0, 1),
                )),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(0, 48),
            ),
            child: const Text(
              'Купить',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
