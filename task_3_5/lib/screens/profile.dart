import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _profileImage =
      'assets/profile_picture.jpg';

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Наумов Святозар';
    _emailController.text = 'svyatozar1@gmail.ru';
  }

  void _changeProfileImage() {
    setState(() {
      _profileImage =
          'assets/profile_picture.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _changeProfileImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(_profileImage),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Имя',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Электронная почта',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Сохранить изменения (например, обновить профиль в базе данных или локальном хранилище)
                final updatedName = _nameController.text;
                final updatedEmail = _emailController.text;

                // Вывод или действия с обновленными данными
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Профиль обновлен: Имя - $updatedName, Email - $updatedEmail'),
                  ),
                );
              },
              child: const Text('Сохранить изменения'),
            ),
          ],
        ),
      ),
    );
  }
}
