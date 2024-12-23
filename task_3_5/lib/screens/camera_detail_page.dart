import 'package:flutter/material.dart';
import '../models/camera.dart';

class CameraDetailPage extends StatelessWidget {
  final Camera camera;

  const CameraDetailPage({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(camera.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(camera.imageUrl, height: 400),
            const SizedBox(height: 20),
            Text(camera.name,
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(camera.description,
                style:
                    const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('${camera.price.toStringAsFixed(0)} ₽',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
