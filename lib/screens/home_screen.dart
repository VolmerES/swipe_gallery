import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // ✅ NUEVO import

void main() {
  runApp(const SwipeGalleryCleanerApp());
}

class SwipeGalleryCleanerApp extends StatelessWidget {
  const SwipeGalleryCleanerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Gallery Cleaner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // ✅ Usa la pantalla importada
    );
  }
}

