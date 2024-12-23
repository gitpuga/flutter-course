import 'package:flutter/material.dart';
import 'package:task_3_5/screens/camera_detail_page.dart';
import '../models/camera.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCameras =
        cameras.where((camera) => camera.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: favoriteCameras.isEmpty
          ? const Center(child: Text('Нет избранных товаров'))
          : ListView.builder(
              itemCount: favoriteCameras.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.asset(favoriteCameras[index].imageUrl,
                        width: 50, height: 50),
                    title: Text(favoriteCameras[index].name),
                    subtitle: Text(
                        '${favoriteCameras[index].price.toStringAsFixed(0)} ₽'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CameraDetailPage(camera: favoriteCameras[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
