import 'package:flutter/material.dart';

void main() {
  // TODO: Esta es la función principal que se ejecuta al iniciar la app.
  // Llama a runApp para cargar la app completa.
  runApp(const SwipeGalleryCleanerApp());
}

// TODO: Clase principal de la aplicación.
// StatelessWidget significa que esta clase no tiene estado interno que cambie.
class SwipeGalleryCleanerApp extends StatelessWidget {
  const SwipeGalleryCleanerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: MaterialApp es el contenedor general de la app.
    // Aquí se define el título, el tema, y la pantalla inicial (home).
    return MaterialApp(
      title: 'Swipe Gallery Cleaner', // TODO: Título de la app
      debugShowCheckedModeBanner: false, // TODO: Oculta la etiqueta de debug
      theme: ThemeData(
        // TODO: Define el esquema de colores usando Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // TODO: Pantalla principal que se muestra al iniciar la app
    );
  }
}

// TODO: Esta es la pantalla principal de la app (HomeScreen).
// Por ahora muestra un texto centrado.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Scaffold proporciona la estructura visual básica (como AppBar, body, etc.)
    return const Scaffold(
      body: Center(
        child: Text(
          'Swipe Gallery Cleaner', // TODO: Texto de bienvenida (temporal)
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
