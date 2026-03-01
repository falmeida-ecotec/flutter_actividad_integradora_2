import 'package:flutter/material.dart';

// Pantalla de perfil que recibe datos desde RegisterScreen
class ProfileScreen extends StatelessWidget {
  final String nombre;
  final String correo;
  final String telefono;

  const ProfileScreen({
    super.key,
    required this.nombre,
    required this.correo,
    required this.telefono,
  });

    @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Perfil de Usuario')),
    body: Center(
      // Card para dar estilo visual tipo tarjeta
      child: Card(
        elevation: 4, // Sombra de la tarjeta
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Bordes redondeados
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar del usuario (ícono por defecto)
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 40),
              ),

              const SizedBox(height: 16),

              // Nombre destacado (más grande y en negrita)
              Text(
                nombre,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Información adicional del usuario
              Text(correo),
              Text(telefono),
            ],
          ),
        ),
      ),
    ),
  );
}
  }