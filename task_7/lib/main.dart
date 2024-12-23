import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_7/components/navbar.dart';
import 'package:task_7/mocks/service_data.dart';
import 'package:task_7/models/service.dart';
import 'package:task_7/pages/cart.dart';
import 'package:task_7/pages/main.dart';
import 'package:task_7/pages/profile.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Service> cartItems = [];
  void addToCart(Service product) {
    setState(() {
      Service? existingItem = cartItems.firstWhere(
        (item) => item == product,
        orElse: () => Service(
          title: product.title,
          description: product.description,
          price: product.price,
          time: product.time,
          quantity: 0,
        ),
      );

      if ((existingItem.quantity ?? 0) > 0) {
        existingItem.quantity = (existingItem.quantity ?? 0) + 1;
      } else {
        cartItems.add(
          Service(
            title: product.title,
            description: product.description,
            price: product.price,
            time: product.time,
            quantity: 1,
          ),
        );
      }
    });
  }

  void increaseQuantity(Service item) {
    setState(() {
      item.quantity = (item.quantity ?? 1) + 1;
    });
  }

  void decreaseQuantity(Service item) {
    setState(() {
      if (item.quantity! > 1) {
        item.quantity = item.quantity! - 1;
      } else {
        // ignore: collection_methods_unrelated_type
        cartItems.remove(item);
      }
    });
  }

  void removeFromCart(Service item) {
    setState(() {
      // ignore: collection_methods_unrelated_type
      cartItems.remove(item);
    });
  }

  void checkout() {
    if (kDebugMode) {
      print('Оформление заказа');
    }
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MainPage(
        items: items,
        onAddToCart: addToCart,
      ),
      CartPage(
        items: cartItems,
        onCheckout: checkout,
        removeFromCart: removeFromCart,
        onIncreaseQuantity: increaseQuantity,
        onDecreaseQuantity: decreaseQuantity,
      ),
      const ProfilePage(),
    ];

    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.montserrat(),
          bodyMedium: GoogleFonts.montserrat(),
          bodySmall: GoogleFonts.montserrat(),
        ),
      ),
      home: Scaffold(
        body: pages.elementAt(_selectedIndex),
        bottomNavigationBar: NavBar(
          selectedIndex: _selectedIndex,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
