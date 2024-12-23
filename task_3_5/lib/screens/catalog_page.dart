import 'package:flutter/material.dart';
import 'camera_detail_page.dart';
import 'add_camera_page.dart';
import '../models/camera.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог фототехники'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCameraPage(
                    onAddCamera: (camera) {
                      setState(() {
                        cameras.add(camera);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cameras.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading:
                  Image.asset(cameras[index].imageUrl, width: 100, height: 100),
              title: Text(cameras[index].name),
              subtitle: Text('${cameras[index].price.toStringAsFixed(0)} ₽'),
              trailing: IconButton(
                icon: Icon(
                  cameras[index].isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: cameras[index].isFavorite ? Colors.green : null,
                ),
                onPressed: () {
                  setState(() {
                    cameras[index].isFavorite = !cameras[index].isFavorite;
                  });
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraDetailPage(camera: cameras[index]),
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
