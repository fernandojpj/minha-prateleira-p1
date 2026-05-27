import 'package:flutter/material.dart';
import 'package:minha_prateleira/screens/home_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Prateleira App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown, 
        useMaterial3: true,
      ),
      home: HomeScreen(), 
    );
  }
}