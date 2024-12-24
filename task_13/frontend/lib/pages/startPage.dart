import 'package:flutter/material.dart';
import 'package:frontend/pages/FavouritePage.dart';
import 'package:frontend/pages/ItemsPage.dart';
import 'package:frontend/pages/ProfilePage.dart';
import 'package:frontend/pages/ShopCartPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widgetOptions = [
      ItemsPage(navToShopCart: (i) => onTab(i)),
      FavoritePage(navToShopCart: (i) => onTab(i)),
      ShopCartPage(navToShopCart: (i) => onTab(i)),
      ProfilePage(navToShopCart: (i) => onTab(i))
    ];
  }

  void onTab(int i) {
    setState(() {
      selectedIndex = i;
    });
  }

  static List<Widget> widgetOptions = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Главная',
              backgroundColor: Color.fromRGBO(255, 255, 255, 1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Избранное',
              backgroundColor: Color.fromRGBO(255, 255, 255, 1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              label: 'Корзина',
              backgroundColor: Color.fromRGBO(255, 255, 255, 1)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
              backgroundColor: Color.fromRGBO(255, 255, 255, 1))
        ],
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 9, 73, 0),
        unselectedItemColor: const Color.fromARGB(255, 5, 161, 0),
        onTap: onTab,
      ),
    );
  }
}
