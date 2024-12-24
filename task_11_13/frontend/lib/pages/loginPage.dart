import 'package:flutter/material.dart';
import 'package:pr13/auth/auth_service.dart';
import 'package:pr13/pages/registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    final email = mailController.text;
    final password = passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: $e",
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 16.0)),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Вход'),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: SingleChildScrollView(
            physics:
                const BouncingScrollPhysics(), // Optional for a smoother scroll experience
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 16.0, top: 200.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        hintText: 'Почта',
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1), width: 1.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1), width: 2.0)),
                      ),
                      controller: mailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        hintText: 'Пароль',
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1), width: 1.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 1), width: 2.0)),
                      ),
                      controller: passwordController,
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
                      onPressed: login,
                      child: const Text('Войти',
                          style: TextStyle(fontSize: 16, color: Colors.black))),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage())),
                      child: const Center(
                          child: Text('Нет аккаунта? Зарегиструйтесь',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black))))
                ],
              ),
            )));
  }
}
