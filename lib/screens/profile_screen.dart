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
        child: Text(
          'Nombre: $nombre\nCorreo: $correo\nTeléfono: $telefono',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}