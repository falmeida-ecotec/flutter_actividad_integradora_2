import 'package:flutter/material.dart';
import 'screens/register_screen.dart';

void main() {
  // Punto de entrada de la aplicación
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug
      title: 'Registro Usuario', // Nombre de la app
      theme: ThemeData(
        useMaterial3: true, // Activa diseño moderno
        colorSchemeSeed: Colors.indigo, // Color principal de la app
      ),
      home: const RegisterScreen(), // Pantalla inicial (registro)
    );
  }
}