import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:my_homework_app/src/controller/globales.dart';
import 'package:my_homework_app/src/services/auth_service.dart';
import 'package:my_homework_app/src/widgets/caja_texto.dart';
import 'package:my_homework_app/src/widgets/custom_elevatedbutton.dart';

class RegistroPage extends StatefulWidget {
  RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // Aquí puedes definir los controladores de texto si es necesario
  final nombre = TextEditingController();
  final correo = TextEditingController();
  final contrasena = TextEditingController();
  final confirmacionContrasena = TextEditingController();

  List<String> especialChars = [
    '@',
    '.',
    '_',
    '-',
    '+',
    '!',
    '#',
    '\$',
    '%',
    '^',
    '&',
    '*',
    '(',
    ')',
    '=',
    '{',
    '}',
    '[',
    ']',
    ':',
    ';',
    '"',
    "'",
    '<',
    '>',
    '?',
    '/',
    '\\',
  ];

  bool hasSpecialChar = false;

  Color colorEmailCheck = Colors.black;

  Color borderColor = Colors.red;

  bool isPassword = true;
  bool isPassword2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 40.0,
            vertical: 40.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Página de Registro'),
                const SizedBox(height: 20),
                CampoTexto(
                  controler: nombre,
                  labeltext: 'Nombre',
                  prefixicon: Icons.person,
                  hinttext: 'Ingrese su nombre',
                  keyboardType: TextInputType.text,
                  suffixicon: null,
                  onchanged: (text) {
                    // lógica para manejar el cambio de texto
                  },
                ),
                const SizedBox(height: 10),
                CampoTexto(
                  controler: correo,
                  labeltext: 'Correo Electrónico',
                  prefixicon: Icons.email,
                  hinttext: 'Ingrese su correo electrónico',
                  keyboardType: TextInputType.emailAddress,
                  suffixicon: null,
                  onchanged: (texto) {
                    // lógica para manejar el cambio de texto
                  },
                ),
                const SizedBox(height: 10),
                CampoTexto(
                  controler: contrasena,
                  labeltext: 'Contraseña',
                  prefixicon: Icons.lock_outline,
                  hinttext: 'Ingrese su contraseña',
                  obscuretext: isPassword,
                  bordercolor: borderColor,
                  suffixicon: IconButton(
                    icon: Icon(
                      isPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                  onchanged: (value) {
                    setState(() {
                      for (String char in especialChars) {
                        if (contrasena.text.contains(char)) {
                          // print('Caracter especial encontrado: $char');
                          hasSpecialChar = true;
                          break;
                        } else {
                          hasSpecialChar = false;
                        }
                      }
                      if (contrasena.text.length < 6 ||
                          hasSpecialChar == false) {
                        borderColor = Colors.red;
                      } else {
                        borderColor = Colors.green;
                      }
                    });
                    // Aquí puedes agregar lógica para validar la contraseña si es necesario
                  },
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 10),
                CampoTexto(
                  controler: confirmacionContrasena,
                  labeltext: 'Contraseña',
                  prefixicon: Icons.lock_outline,
                  hinttext: 'Ingrese su contraseña',
                  obscuretext: isPassword2,
                  bordercolor: borderColor,
                  suffixicon: IconButton(
                    icon: Icon(
                      isPassword2 ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPassword2 = !isPassword2;
                      });
                    },
                  ),
                  onchanged: (value) {
                    setState(() {
                      for (String char in especialChars) {
                        if (confirmacionContrasena.text.contains(char)) {
                          // print('Caracter especial encontrado: $char');
                          hasSpecialChar = true;
                          break;
                        } else {
                          hasSpecialChar = false;
                        }
                      }
                      if (confirmacionContrasena.text != contrasena.text) {
                        borderColor = Colors.red;
                      } else {
                        borderColor = Colors.green;
                      }
                    });
                    // Aquí puedes agregar lógica para validar la contraseña si es necesario
                  },
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20),
                Boton(
                  onpressed: _isLoading ? null : _register,
                  texto: _isLoading ? 'Registrando...' : 'Registrar',
                ),
                 TextButton(
                onPressed: () {
                  context.push('/login');
                },
                child: Text(
                  '¿Ya tienes una cuenta?',
                  style: TextStyle(color: Colors.blue),
                ),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    nombre.dispose();
    correo.dispose();
    contrasena.dispose();
    confirmacionContrasena.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Crear usuario con Firebase Auth
      final user = await _auth.signUpWithEmail(
        nombre.text.trim(),
        correo.text.trim(),
        contrasena.text.trim(),
      );
      Sesion.setUsuario(user);
      SnackBar(
        content: Text('Registro exitoso. Bienvenido ${user!.displayName}!'),
        backgroundColor: Colors.green,
      );
      // Navegar a la pantalla principal después de registro exitoso
      if (context.mounted) {
          context.go('/home_layout', extra: {'page': 'home'});
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'La contraseña es demasiado débil.';
          break;
        case 'email-already-in-use':
          errorMessage = 'El correo ya está registrado.';
          break;
        case 'invalid-email':
          errorMessage = 'El correo electrónico no es válido.';
          break;
        default:
          errorMessage = 'Error al registrar: ${e.message}';
      }
      setState(() {
        _errorMessage = errorMessage;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error inesperado: $e';
        _isLoading = false;
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
        );
      });
    }
  }
}
