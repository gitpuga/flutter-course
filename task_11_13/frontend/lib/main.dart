import 'package:flutter/material.dart';
import 'package:pr13/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://djodfgujjgpbmazzwvdy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRqb2RmZ3VqamdwYm1henp3dmR5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQzNTY1NzYsImV4cCI6MjA0OTkzMjU3Nn0.ppI7F-1gZtm02Ned0o4YzZ563hRAxQcIMeKORYE1pUY',
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
