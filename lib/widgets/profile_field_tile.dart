import 'package:flutter/material.dart';

// Widget reutilizable para mostrar un campo del perfil (ej: Correo, Teléfono)
class ProfileFieldTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileFieldTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}