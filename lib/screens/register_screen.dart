import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'profile_screen.dart';
import '../widgets/custom_text_field.dart';

// Pantalla de registro convertida a StatefulWidget
// porque necesitamos manejar estado (formulario y validaciones)
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Clave global para validar el formulario completo
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controladores para capturar lo que escribe el usuario
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    // Liberar memoria de los controladores cuando la pantalla se destruye
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  // Método que se ejecuta al presionar "Guardar"
   Future<void> _submit() async {
    // Ejecuta todas las validaciones del formulario
    if (_formKey.currentState!.validate()) {
      // Inserta el usuario en SQLite usando el DatabaseHelper
      await DatabaseHelper.instance.insertUser(
        nombre: _nameCtrl.text.trim(),
        correo: _emailCtrl.text.trim(),
        telefono: _phoneCtrl.text.trim(),
      );

      // Confirmación visual para el usuario
      if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario guardado en SQLite ✅')),
      );
      // Navegación a la pantalla de perfil
      Navigator.push(
        context,
        MaterialPageRoute(
         builder: (context) => ProfileScreen(
          nombre: _nameCtrl.text.trim(),
          correo: _emailCtrl.text.trim(),
          telefono: _phoneCtrl.text.trim(),
         ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Asociamos el formulario a la clave
          child: Column(
            children: [
              // Campo: Nombre
              CustomTextField(
                controller: _nameCtrl,
                label: 'Nombre',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                  return 'El nombre es obligatorio';
                }
                  if (value.trim().length < 3) {
                  return 'Mínimo 3 caracteres';
                }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Campo: Correo
              CustomTextField(
                controller: _emailCtrl,
                label: 'Correo',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  final email = value?.trim() ?? '';
                  if (email.isEmpty) return 'El correo es obligatorio';
                  if (!email.contains('@') || !email.contains('.')) {
                  return 'Correo no válido';
                }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Campo: Teléfono
              CustomTextField(
                controller: _phoneCtrl,
                label: 'Teléfono',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  final phone = value?.trim() ?? '';
                  if (phone.isEmpty) return 'El teléfono es obligatorio';
                  if (phone.length < 8) return 'Mínimo 8 dígitos';
                  if (!RegExp(r'^\d+$').hasMatch(phone)) {
                  return 'Solo números';
                }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Botón de envío del formulario
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit, // Ejecuta validación
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}