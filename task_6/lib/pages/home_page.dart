import 'package:flutter/material.dart';
import 'package:task_6/models/cart_item.dart';
import 'package:task_6/pages/product_page.dart';
import '../components/product_card.dart';
import '../mocks/products_mock.dart';
import '../mocks/basket_products.dart';
import '../pages/add_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void toProductPage(BuildContext context, int index) {
    var product = products[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(
          product: product,
          onBasketAdd: () {
            items.add(CartItemModel(product.id, product.title,
                product.description, product.imgUrl, product.price, 1));
          },
          toggleFavorite: () => setState(() {
            products[index].isFavorite = !products[index].isFavorite;
          }),
          onDelete: () {
            setState(() {
              products.remove(product);
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Популярные товары'),
      ),
      backgroundColor: Colors.white,
      body: GridView.count(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
        children: List.generate(products.length, (index) {
          return GestureDetector(
            onTap: () => toProductPage(context, index),
            child: ProductCard(product: products[index]),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(onAddProduct: (newItem) {
                setState(() {
                  products.add(newItem);
                });
              }),
            ),
          );
        },
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        child: const Icon(Icons.add),
      ),
    );
  }
}
