import 'package:flutter/material.dart';
import 'package:task_8_9/Pages/FavouritePage.dart';
import 'package:task_8_9/Pages/ItemsPage.dart';
import 'package:task_8_9/Pages/ProfilePage.dart';
import 'package:task_8_9/Pages/ShopCartPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

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
      const ProfilePage()
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
        selectedItemColor: const Color.fromRGBO(0, 70, 20, 1),
        unselectedItemColor: const Color.fromARGB(255, 164, 164, 164),
        onTap: onTab,
      ),
    );
  }
}
