import 'package:flutter/material.dart';
import 'package:frontend/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ogibrbvxhceopqngsfrz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9naWJyYnZ4aGNlb3BxbmdzZnJ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzUwMDI2NzIsImV4cCI6MjA1MDU3ODY3Mn0.9CfQcjvTyTZtngAjENOdPLFLpCE7Gt95SbCMosWnlKg',
  );
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
      home: const AuthGate(),
    );
  }
}
