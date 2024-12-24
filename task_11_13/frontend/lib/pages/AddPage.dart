import 'package:flutter/material.dart';
import 'package:pr13/api_service.dart';
import 'package:pr13/model/items.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _addController1 = TextEditingController();
  final TextEditingController _addController2 = TextEditingController();
  final TextEditingController _addController3 = TextEditingController();
  final TextEditingController _addController4 = TextEditingController();
  String img_link = '';

  void enter_img(String text) {
    setState(() {
      img_link = text;
    });
  }

  void AddItem() async {
    if (int.tryParse(_addController3.text) != null &&
        _addController1.text.isNotEmpty &&
        _addController2.text.isNotEmpty &&
        _addController3.text.isNotEmpty &&
        _addController4.text.isNotEmpty) {
      await ApiService().addProduct(Items(
        id: 0,
        name: _addController1.text,
        image: _addController2.text,
        cost: double.parse(_addController3.text),
        describtion: _addController4.text,
        favorite: false,
        shopcart: false,
        count: 0,
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Товары'),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: 'Название товара',
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1), width: 1.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1), width: 2.0)),
                      ),
                      controller: _addController1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.black),
                            decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              hintText: 'Ссылка на картинку',
                              hintStyle:
                                  TextStyle(fontSize: 14.0, color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      width: 1.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      width: 2.0)),
                            ),
                            controller: _addController2,
                            onChanged: (text) {
                              enter_img(text);
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                              ),
                              child: Image.network(
                                img_link,
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.width * 0.2,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const CircularProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        hintText: 'Цена товара',
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1), width: 1.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1), width: 2.0)),
                      ),
                      controller: _addController3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        hintText: 'Описание товара',
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1), width: 1.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1), width: 2.0)),
                      ),
                      controller: _addController4,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.only(
                              bottom: 13.0, top: 13.0, right: 30.0, left: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      onPressed: () {
                        AddItem();
                      },
                      child: const Text('Сохранить',
                          style: TextStyle(fontSize: 16, color: Colors.black)))
                ],
              ),
            )));
  }
}
