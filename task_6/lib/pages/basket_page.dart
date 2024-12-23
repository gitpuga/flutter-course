import 'package:flutter/material.dart';
import 'package:task_6/components/basket_bottom.dart';
import 'package:task_6/components/basket_card.dart';
import 'package:task_6/mocks/basket_products.dart';
import 'package:task_6/mocks/products_mock.dart';
import 'package:task_6/models/cart_item.dart';
import 'package:task_6/pages/product_page.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final List<CartItemModel> _items = items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              var item = _items[index];
              var product =
                  products.firstWhere((element) => item.id == element.id);

              return BasketItem(
                item: item,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        product: product,
                        onDelete: () {
                          setState(() {
                            items.remove(item);
                            products.removeWhere(
                                (element) => element.id == item.id);
                          });
                        },
                        onBasketAdd: () {},
                        toggleFavorite: () {
                          setState(() {
                            var product = products
                                .firstWhere((element) => element.id == item.id);
                            product.isFavorite = !product.isFavorite;
                          });
                        },
                      ),
                    ),
                  );
                },
                onCount: (int value) {
                  setState(() {
                    item.count = value;
                  });
                },
                deleteItem: () {
                  setState(() {
                    items.remove(item);
                  });
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: BasketBottom(
            price: sumPrices(),
            count: getCartTotalCount(),
          ),
        ),
      ],
    ));
  }

  int getCartTotalCount() {
    int count = 0;

    for (int i = 0; i < items.length; i++) {
      count = count + items[i].count;
    }
    return count;
  }

  int sumPrices() {
    int sum = 0;

    for (int i = 0; i < items.length; i++) {
      sum += items[i].cost * items[i].count;
    }
    return sum;
  }
}
