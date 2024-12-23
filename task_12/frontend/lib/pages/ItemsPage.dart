import 'package:flutter/material.dart';
import 'package:frontend/Pages/AddPage.dart';
import 'package:frontend/Pages/ItemPage.dart';
import 'package:frontend/api_service.dart';
import 'package:frontend/auth/auth_service.dart';
import 'package:frontend/model/items.dart';
import 'package:frontend/pages/FiltersPage.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key, required this.navToShopCart});

  final Function(int i) navToShopCart;

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final userEmail = AuthService().getCurrentUserEmail();
  late Future<List<Items>> ItemsList;
  late List<Items> UpdatedItemsList;

  String searchQuery = '';
  bool isAscending = true;
  double? minPrice;
  double? maxPrice;
  List<String> filters = [];

  @override
  void initState() {
    super.initState();
    ItemsList = ApiService().getProducts(userEmail!);
    ApiService().getProducts(userEmail!).then(
          (value) => {
            UpdatedItemsList = value
                .where((item) => item.name.toLowerCase().contains(searchQuery))
                .toList()
          },
        );
  }

  void _refreshData() {
    setState(() {
      ItemsList = ApiService().getProducts(userEmail!);
      ApiService().getProducts(userEmail!).then(
            (value) => {
              UpdatedItemsList = value
                  .where(
                      (item) => item.name.toLowerCase().contains(searchQuery))
                  .toList()
            },
          );
    });
  }

  void AddFavorite(
    Items this_item,
  ) {
    Items new_item = Items(
        id: this_item.id,
        name: this_item.name,
        image: this_item.image,
        cost: this_item.cost,
        describtion: this_item.describtion,
        favorite: !this_item.favorite,
        shopcart: this_item.shopcart,
        count: this_item.count);
    if (!this_item.favorite) {
      ApiService().addProductFavorite(new_item, userEmail!);
    } else {
      ApiService().deleteProductFavorite(userEmail!, new_item.id);
    }

    setState(() {
      UpdatedItemsList.elementAt(
              UpdatedItemsList.indexWhere((el) => el.id == this_item.id))
          .favorite = !this_item.favorite;
    });
  }

  void AddShopCart(Items this_item) async {
    if (!this_item.shopcart) {
      Items new_item = Items(
          id: this_item.id,
          name: this_item.name,
          image: this_item.image,
          cost: this_item.cost,
          describtion: this_item.describtion,
          favorite: !this_item.favorite,
          shopcart: this_item.shopcart,
          count: this_item.count);
      ApiService().addProductShopCart(new_item, userEmail!);
    }
    setState(() {
      UpdatedItemsList.elementAt(
              UpdatedItemsList.indexWhere((el) => el.id == this_item.id))
          .shopcart = true;
      UpdatedItemsList.elementAt(
          UpdatedItemsList.indexWhere((el) => el.id == this_item.id)).count = 1;
    });
  }

  void NavToAdd(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPage()),
    );
    _refreshData();
  }

  void NavToItem(index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemPage(
          index: index,
          navToShopCart: (i) => widget.navToShopCart(i),
        ),
      ),
    );
    _refreshData();
  }

  void increment(Items this_item) {
    Items new_item = Items(
        id: this_item.id,
        name: this_item.name,
        image: this_item.image,
        cost: this_item.cost,
        describtion: this_item.describtion,
        favorite: this_item.favorite,
        shopcart: this_item.shopcart,
        count: this_item.count + 1);
    ApiService().updateProductShopCart(new_item, userEmail!);
    setState(() {
      UpdatedItemsList.elementAt(
              UpdatedItemsList.indexWhere((el) => el.id == this_item.id))
          .count += 1;
    });
  }

  void decrement(Items this_item) {
    final count = this_item.count;
    if (count == 1) {
      ApiService().deleteProductShopCart(userEmail!, this_item.id);
    } else {
      Items new_item = Items(
          id: this_item.id,
          name: this_item.name,
          image: this_item.image,
          cost: this_item.cost,
          describtion: this_item.describtion,
          favorite: this_item.favorite,
          shopcart: this_item.shopcart,
          count: this_item.count - 1);
      ApiService().updateProductShopCart(new_item, userEmail!);
    }
    setState(() {
      if (count == 1) {
        UpdatedItemsList.elementAt(
                UpdatedItemsList.indexWhere((el) => el.id == this_item.id))
            .shopcart = false;
      } else {
        UpdatedItemsList.elementAt(
                UpdatedItemsList.indexWhere((el) => el.id == this_item.id))
            .count -= 1;
      }
    });
  }

  void _sortItems(String option) {
    setState(() {
      ItemsList = ApiService().getProducts(userEmail!).then((value) {
        UpdatedItemsList = value;
        if (option == 'По возрастанию цены') {
          UpdatedItemsList.sort((a, b) => a.cost.compareTo(b.cost));
        } else if (option == 'По убыванию цены') {
          UpdatedItemsList.sort((a, b) => b.cost.compareTo(a.cost));
        }
        return UpdatedItemsList;
      });
    });
  }

  void _filterItems() async {
    final answer = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Filters()));
    setState(() {
      minPrice = answer['minPrice'];
      maxPrice = answer['maxPrice'];
      filters = answer['filters'];
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      ItemsList = ApiService().getProducts(userEmail!).then((fetchedItems) {
        UpdatedItemsList = fetchedItems.where((item) {
          bool matchesPrice = true;
          if (minPrice != null) matchesPrice = item.cost >= minPrice!;
          if (maxPrice != null) {
            matchesPrice = matchesPrice && item.cost <= maxPrice!;
          }

          bool matchesFilters = filters.isEmpty ||
              filters.any((filter) {
                return item.describtion
                    .toLowerCase()
                    .contains(filter.toLowerCase());
              });

          return matchesPrice && matchesFilters;
        }).toList();

        return UpdatedItemsList;
      });
    });
  }

  void _searchItems(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      ApiService().getProducts(userEmail!).then(
            (value) => {
              UpdatedItemsList = value
                  .where(
                      (item) => item.name.toLowerCase().contains(searchQuery))
                  .toList()
            },
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Товары'),
          backgroundColor: Colors.white70,
          actions: [
            IconButton(
              icon: const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
              onPressed: () {
                NavToAdd(context);
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton<String>(
                        onSelected: _sortItems,
                        itemBuilder: (BuildContext context) {
                          return {'По возрастанию цены', 'По убыванию цены'}
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                        icon: const Icon(Icons.sort),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          onChanged: _searchItems,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  right: 10, left: 10, bottom: 0, top: 0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    width: 1),
                              ),
                              labelText: 'Поиск'),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          cursorHeight: 20.0,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () => {
                          setState(() {
                            _filterItems();
                          })
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Items>>(
                    future: ItemsList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No products found'));
                      }

                      final ItemsList = snapshot.data!
                          .where((item) =>
                              item.name.toLowerCase().contains(searchQuery))
                          .toList();

                      return ItemsList.length != 0
                          ? GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.63,
                              ),
                              itemCount: ItemsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    NavToItem(ItemsList.elementAt(index).id);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5.0,
                                        left: 5.0,
                                        top: 2.0,
                                        bottom: 5.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Image.network(
                                              ItemsList.elementAt(index).image,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return const CircularProgressIndicator();
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  child: const Center(
                                                      child: Text(
                                                    'нет картинки',
                                                    softWrap: true,
                                                    textAlign: TextAlign.center,
                                                  )),
                                                );
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0,
                                                bottom: 0.0,
                                                right: 15.0,
                                                left: 15.0),
                                            child: SizedBox(
                                              height: 35.0,
                                              child: Text(
                                                '${ItemsList.elementAt(index).name}',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 5.0),
                                            child: Row(children: [
                                              const Text(
                                                'Цена: ',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                '${ItemsList.elementAt(index).cost} ₽',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: IconButton(
                                                      onPressed: () => {
                                                            AddFavorite(
                                                                UpdatedItemsList
                                                                    .elementAt(
                                                                        index))
                                                          },
                                                      icon: UpdatedItemsList
                                                                  .elementAt(
                                                                      index)
                                                              .favorite
                                                          ? const Icon(
                                                              Icons.favorite)
                                                          : const Icon(Icons
                                                              .favorite_border)),
                                                ),
                                              ),
                                            ]),
                                          ),
                                          //Количество товаров в корзине
                                          UpdatedItemsList.elementAt(index)
                                                  .shopcart
                                              ? SizedBox(
                                                  height: 40.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            right: 5.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              icon: Icon(
                                                                  Icons.remove),
                                                              onPressed:
                                                                  () => {
                                                                        decrement(
                                                                            UpdatedItemsList.elementAt(index))
                                                                      }),
                                                          Container(
                                                            height: 25.0,
                                                            width: 30.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              border: Border.all(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      0,
                                                                      0,
                                                                      0),
                                                                  width: 2),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1.0),
                                                              child: Text(
                                                                UpdatedItemsList
                                                                        .elementAt(
                                                                            index)
                                                                    .count
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: Colors
                                                                        .black),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              icon: Icon(
                                                                  Icons.add),
                                                              onPressed:
                                                                  () => {
                                                                        increment(
                                                                            UpdatedItemsList.elementAt(index))
                                                                      }),
                                                        ]),
                                                  ),
                                                )
                                              //Добавление в корзину
                                              : Expanded(
                                                  child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10.0),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            const Color
                                                                .fromARGB(
                                                                255, 0, 0, 0),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            side: const BorderSide(
                                                                width: 2,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0))),
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                255, 255, 255),
                                                      ),
                                                      child: const Text(
                                                          "В корзину",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                      onPressed: () {
                                                        AddShopCart(
                                                            ItemsList.elementAt(
                                                                index));
                                                      },
                                                    ),
                                                  ),
                                                ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : const Center(child: Text('Нет товаров'));
                    }),
              ),
            ],
          ),
        ));
  }
}
