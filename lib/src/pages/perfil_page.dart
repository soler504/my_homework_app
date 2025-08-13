import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:get/get.dart';
// import 'package:my_homework_app/src/controller/globales.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = true;
  bool _darkMode = false;
  bool _notifications = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    _user = _auth.currentUser;
    setState(() => _isLoading = false);
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      context.go('/');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cerrar sesión: ${e.toString()}')),
      );
    }
  }

  Widget _buildProfileImage() {
    final double radius = 50;

    if (_user?.photoURL != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(_user!.photoURL!),
      );
    }

    // Mostrar iniciales si no hay imagen
    final initials = _user?.displayName?.isNotEmpty == true
        ? _user!.displayName!.split(' ').map((n) => n[0]).take(2).join()
        : 'U';

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.blueAccent,
      child: Text(
        initials,
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_user == null) {
      return Center(child: Text('Usuario no autenticado'));
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Center(child: _buildProfileImage()),
          SizedBox(height: 16),
          Text(
            _user?.displayName ?? 'Nombre no establecido',
            // style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 8),
          Text(
            _user?.email ?? 'Correo no disponible',
            // style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 24),

          // Sección de Preferencias
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preferencias',
                    // style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  SwitchListTile(
                    title: Text('Modo oscuro'),
                    value: _darkMode,
                    onChanged: (value) => setState(() => _darkMode = value),
                  ),
                  SwitchListTile(
                    title: Text('Notificaciones'),
                    value: _notifications,
                    onChanged: (value) =>
                        setState(() => _notifications = value),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),

          // Botón para cerrar sesión
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: Icon(Icons.logout),
              label: Text('Cerrar sesión'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Cerrar sesión'),
                    content: Text(
                      '¿Estás seguro de que quieres cerrar sesión?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _signOut();
                        },
                        child: Text(
                          'Cerrar sesión',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
